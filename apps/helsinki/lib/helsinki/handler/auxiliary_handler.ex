defmodule AccountingSystem.AuxiliaryHandler do
  @moduledoc """
  The Auxiliaries context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AccountHandler,
    AuxiliarySchema,
    PrefixFormatter,
    Repo,
    GenericFunctions,
    GetHeaderQuery,
    GetDetailsQuery
  }

  @doc """
  Returns the list of auxiliaries.

  ## Examples

      iex> list_auxiliaries()
      [%Auxiliary{}, ...]

  """
  def list_auxiliaries do
    Repo.all(AuxiliarySchema, prefix: PrefixFormatter.get_current_prefix)
  end

  def list_auxiliaries(year, month) do
    Repo.all(AuxiliarySchema, prefix: PrefixFormatter.get_prefix(year, month))
  end

  @doc """
  Gets a single auxiliary.

  Raises `Ecto.NoResultsError` if the Auxiliary does not exist.

  ## Examples

      iex> get_auxiliary!(123)
      %Auxiliary{}

      iex> get_auxiliary!(456)
      ** (Ecto.NoResultsError)

  """
  def get_auxiliary!(id), do: Repo.get!(AuxiliarySchema, id, prefix: PrefixFormatter.get_current_prefix)

  def get_auxiliary!(id, year, month), do: Repo.get!(AuxiliarySchema, id, prefix: PrefixFormatter.get_prefix(year, month))

  def get_auxiliary_by_policy_id(id), do: Repo.all(AccountingSystem.GetAllId.get_auxiliary_by_policy_id(id), prefix: PrefixFormatter.get_current_prefix)

  @doc """
  Creates a auxiliary.

  ## Examples

      iex> create_auxiliary(%{field: value})
      {:ok, %Auxiliary{}}

      iex> create_auxiliary(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_auxiliary(attrs \\ %{}) do
    attrs = load_xml_id(attrs)
    xml_b64 = attrs.xml_b64
    %AuxiliarySchema{}
    |> AuxiliarySchema.changeset(attrs)
    |> Repo.insert(prefix: PrefixFormatter.get_current_prefix)
    |> case do
      {:ok, aux} ->
        if aux.id != nil do
        save_in_alexandria(xml_b64, aux.xml_id, aux.xml_name)
        aux
      end
      {:error, aux} -> aux |> GenericFunctions.to_inspect(" -> ERROR AUX NOT SAVED")
    end
  end

  def create_auxiliary(attrs \\ %{}, year, month) do
    attrs = load_xml_id(attrs)
    xml_b64 = attrs.xml_b64
    %AuxiliarySchema{}
    |> AuxiliarySchema.changeset(attrs)
    |> Repo.insert(prefix: PrefixFormatter.get_prefix(year, month))
    |> case do
      {:ok, aux} -> if aux.xml_id != nil, do: save_in_alexandria(xml_b64, aux.xml_id, aux.xml_name)
      {:error, aux} -> aux
    end
  end

  defp load_xml_id(attrs) do
      attrs |> Map.put(:xml_id, (if attrs.xml_name != GenericFunctions.to_string_empty, do: Ecto.UUID.autogenerate, else: GenericFunctions.to_string_empty))
  end

  defp load_xml_id_edit(attrs) do
    if is_nil(attrs.xml_id) and !is_nil(attrs.xml_name) do
      attrs |> Map.put(:xml_id, (if attrs.xml_name != GenericFunctions.to_string_empty, do: Ecto.UUID.autogenerate, else: GenericFunctions.to_string_empty))
    else
      attrs
    end
  end

  defp save_in_alexandria(xml_b64, xml_id, xml_name) do
    AccountingSystem.Alexandria.upload_file(xml_b64, xml_name, xml_id)
  end

  def get_xml_file_to_alexandria(xml_id) do
    case AccountingSystem.Alexandria.get_file(xml_id, 1) do
      {:ok, xml} -> xml.body
      {_, xml} -> xml
    end
  end

  @doc """
  Updates a auxiliary.

  ## Examples

      iex> update_auxiliary(auxiliary, %{field: new_value})
      {:ok, %Auxiliary{}}

      iex> update_auxiliary(auxiliary, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_auxiliary(%AuxiliarySchema{} = auxiliary, attrs) do
    attrs = load_xml_id_edit(attrs)
    xml_b64 = if Map.has_key?(attrs, :xml_b64), do: attrs.xml_b64, else: GenericFunctions.to_string_empty
    auxiliary
    |> AuxiliarySchema.changeset(attrs)
    |> Repo.update(prefix: PrefixFormatter.get_current_prefix)
    |> case do
      {:ok, aux} -> if aux.xml_id != nil and xml_b64 != "", do: save_in_alexandria(xml_b64, attrs.xml_id, attrs.xml_name)
      {:error, aux} -> aux
    end
  end

  def update_auxiliary(%AuxiliarySchema{} = auxiliary, attrs, year, month) do
    auxiliary
    |> AuxiliarySchema.changeset(attrs)
    |> Repo.update(prefix: PrefixFormatter.get_prefix(year, month))
  end

  @doc """
  Deletes a auxiliary.

  ## Examples

      iex> delete_auxiliary(auxiliary)
      {:ok, %Auxiliary{}}

      iex> delete_auxiliary(auxiliary)
      {:error, %Ecto.Changeset{}}

  """
  def delete_auxiliary(%AuxiliarySchema{} = auxiliary) do
    Repo.delete(auxiliary, prefix: PrefixFormatter.get_current_prefix)
  end

  def delete_auxiliary(%AuxiliarySchema{} = auxiliary, year, month) do
    Repo.delete(auxiliary, prefix: PrefixFormatter.get_prefix(year, month))
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking auxiliary changes.

  ## Examples

      iex> change_auxiliary(auxiliary)
      %Ecto.Changeset{source: %Auxiliary{}}

  """
  def change_auxiliary(%AuxiliarySchema{} = auxiliary) do
    AuxiliarySchema.changeset(auxiliary, %{})
  end

  #****************************************************************************************************
  def validate_auxiliar(params) do #Valida si los parametros de auxiliar estan completos
    case are_complete(params) do
      false ->
        {:ok, params}
      true ->
        {:error, params}
    end
  end

  defp are_complete(params) do #Revisa que todos los valorews estén OKAYYYY
    params
      |> Enum.map(fn data -> check(data, params) end)
      |> Enum.any?(fn report ->
                {some, _} = report
                some == :error
              end)
  end

  defp check(:error, params), do: {:error, params}
  defp check({"account" , ""}, params), do: {:error, params}
  defp check({"aux_concept" , ""}, params), do: {:error, params}
  defp check({"credit" , ""}, params), do: {:error, params}
  defp check({"debit" , ""}, params), do: {:error, params}
  defp check({"id_account" , ""}, params), do: {:error, params}
  defp check({"account" , _}, params), do: {:ok, params}
  defp check({"aux_concept" , _}, params), do: {:ok, params}
  defp check({"credit" , _}, params), do: {:ok, params}
  defp check({"debit" , _}, params), do: {:ok, params}
  defp check({"id_account" , _}, params), do: {:ok, params}
  defp check({_, _}, params), do: {:ok, params}

  def format_to_save(params, policy_number, policy_id) do
    params = Map.merge(params, %{debit_credit: h_or_d(params)})
              |> Map.merge(%{mxn_amount: amount(params)})
              |> Map.merge(%{amount: amount(params)})
              |> Map.merge(%{exchange_rate: 1})
              |> Map.merge(%{policy_id: policy_id})
              |> Map.merge(%{policy_number: policy_number})
              |> Map.merge(%{concept: params.aux_concept})
              |> Map.delete(:credit)
              |> Map.delete(:debit)
    params
  end

  def format_to_update(params) do
    params = Map.merge(params, %{debit_credit: h_or_d(params)})
              |> Map.merge(%{mxn_amount: amount(params)})
              |> Map.merge(%{amount: amount(params)})
              |> Map.merge(%{concept: params.aux_concept})
              |> Map.delete(:credit)
              |> Map.delete(:debit)
    params
  end

  def h_or_d(%{credit: hab}) do
    case to_float(hab) do
      0.0 ->
        "D"
      _ ->
        "H"
    end
  end

  def amount(%{credit: hab}) when hab != "0" and hab != 0 and hab != "0.0" and hab != 0.0 do
    to_float(hab)
  end

  def amount(%{debit: deb}) when deb != "0" and deb != 0 and deb != "0.0" and deb != 0.0 do
    to_float(deb)
  end

  def amount(_) do
    0.0
  end

  def to_float(x) when is_bitstring(x), do: void(x)
  def to_float(x) when is_integer(x), do: x / 1
  def to_float(x) when is_float(x), do: x

  def void(some) do
    case some do
      0 -> 0.0
      _ -> some
            |> Float.parse
            |> Tuple.to_list
            |> List.first
    end
  end

  def cancel_auxiliary(id_to_cancel) do
    id_to_cancel
    |> get_auxiliary_by_policy_id
    |> Enum.each(fn aux -> update_auxiliary(aux.id |> get_auxiliary!, %{"mxn_amount" => "0.0", "amount" => "0.0"}) end)
  end

  def get_max_id_by_policy(policy_id) do
    AccountingSystem.GetMaxId.by_policy_id(policy_id)
      |> Repo.all(prefix: PrefixFormatter.get_current_prefix)
      |> List.first
  end

  def get_aux_report(start_date, end_date, initial_account, final_account) do
    period_list = PrefixFormatter.get_period_list(start_date, end_date)
    combine_accounts(
      AccountHandler.list_detail_range_accounts(initial_account, final_account),
      get_headers_list(period_list, [], start_date, end_date),
      [])
    |> Enum.filter(fn x -> !is_nil(x) end)
    # |> Enum.filter(fn x -> x.id == 182 end)
    |> add_details(period_list, [], start_date, end_date)
  end

  def get_aux_report(start_date, end_date) do
    period_list = PrefixFormatter.get_period_list(start_date, end_date)
    combine_accounts(
      AccountHandler.list_detail_accounts,
      get_headers_list(period_list, [], start_date, end_date),
      [])
    |> Enum.filter(fn x -> !is_nil(x) end)
    # |> Enum.filter(fn x -> x.id == 151 end)
    |> add_details(period_list, [], start_date, end_date)
  end

  defp get_headers_list([h | t], new_list, start_date, end_date) do
    get_headers_list(
      t,
      new_list ++ (GetHeaderQuery.header(start_date, end_date) |> Repo.all(prefix: h)),
      start_date, end_date)
  end

  defp get_headers_list([], new_list, _start_date, _end_date), do: new_list

  defp combine_accounts([h | t], headers, new_list) do
    combine_accounts(t, headers, List.insert_at(new_list, 0, combine_header(headers, h, 0, 0, %{})))
  end

  defp combine_accounts([], _headers, new_list), do: new_list

  defp combine_header([h | t], account, new_debe, new_haber, new_header) do
    if account.id == h.id do
      new_debe = new_debe + h.debe
      new_haber = new_haber + h.haber
      combine_header(t, account, new_debe, new_haber, Map.put(h, :debe, new_debe) |> Map.put(:haber, new_haber))
    else
      combine_header(t, account,
      (if new_header == %{}, do: 0, else: new_header.debe), (if new_header == %{}, do: 0, else: new_header.haber),
      new_header)
    end
  end

  defp combine_header([], _account, _new_debe, _new_haber, new_header), do: if new_header != %{}, do: new_header, else: nil

  defp add_details([h | t], periods, new_list, start_date, end_date) do
    add_details(
      t,
      periods,
      List.insert_at(new_list, 0, Map.put(h, :details, get_details(periods, h.id, [], start_date, end_date))),
      start_date,
      end_date)
  end

  defp add_details([], _periods, new_list, _start_date, _end_date), do: new_list

  defp get_details([h | t], id, new_list, start_date, end_date) do
    get_details(t, id, new_list ++ (GetDetailsQuery.details(id, start_date, end_date) |> Repo.all(prefix: h)), start_date, end_date)
  end

  defp get_details([], _id, new_list, _start_date, _end_date), do: new_list

end
