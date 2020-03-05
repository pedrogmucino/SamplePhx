defmodule AccountingSystem.AuxiliaryHandler do
  @moduledoc """
  The Auxiliaries context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliarySchema,
    PrefixFormatter,
    Repo,
    GenericFunctions
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
    %AuxiliarySchema{}
    |> AuxiliarySchema.changeset(attrs)
    |> Repo.insert(prefix: PrefixFormatter.get_current_prefix)
  end

  def create_auxiliary(attrs \\ %{}, year, month) do
    %AuxiliarySchema{}
    |> AuxiliarySchema.changeset(attrs |> Map.put(:concept, attrs.aux_concept))
    |> Repo.insert(prefix: PrefixFormatter.get_prefix(year, month))
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
    IO.inspect(attrs, label: "ATTRS Del updateeeeeeeeeeeeeee-------------->>>>>>>>>>>>>")
    auxiliary
    |> AuxiliarySchema.changeset(attrs)
    |> IO.inspect(label: "Changeset de Update Aux ----------------------------------->")
    |> Repo.update(prefix: PrefixFormatter.get_current_prefix)
    |> IO.inspect(label: "Respuesta de REPO UPdate ----------------------------------->")
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
      8 ->
        {:ok, params}
      _ ->
        {:error, params}

    end
  end

  defp are_complete(params) do #regresa la cantidad de valores no vacios de un mapa
    params
      |> Map.values
      #|> Enum.reject(fn x -> x == "" end)
      |> Enum.count
  end

  def format_to_save(params, policy_number, policy_id) do
    params = Map.merge(params, %{debit_credit: h_or_d(params)})
              |> Map.merge(%{mxn_amount: amount(params)})
              |> Map.merge(%{amount: amount(params)})
              |> Map.merge(%{exchange_rate: 1})
              |> Map.merge(%{policy_id: policy_id})
              |> Map.merge(%{policy_number: policy_number})
              |> Map.delete(:credit)
              |> Map.delete(:debit)
              |> Map.delete(:id)
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
    IO.inspect(hab, label: "AMOUNT CREDIT ---------------------------------------->")
    to_float(hab)
  end

  def amount(%{debit: deb}) when deb != "0" and deb != 0 and deb != "0.0" and deb != 0.0 do
    IO.inspect(deb, label: "AMOUNT DEBIT ---------------------------------------->")
    to_float(deb)
  end

  def amount(_) do
    0.0
  end

  def to_float(x) when is_bitstring(x), do: void(x)
  def to_float(x) when is_integer(x), do: x/1
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
end
