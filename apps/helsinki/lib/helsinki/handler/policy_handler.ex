defmodule AccountingSystem.PolicyHandler do
  @moduledoc """
  The Policies context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliaryHandler,
    PolicySchema,
    PrefixFormatter,
    Repo,
    PolicyFormatter,
    GenericFunctions,
    SeriesHandler,
    PolicyListQuery
  }

  @doc """
  Returns the list of policies.

  ## Examples

      iex> list_policies()
      [%Policy{}, ...]

  """
  def list_policies do
    Repo.all(PolicySchema, prefix: PrefixFormatter.get_current_prefix)
  end

  def list_policies(year, month) do
    Repo.all(PolicySchema, prefix: PrefixFormatter.get_prefix(year, month))
  end

  def get_policy_list() do
    PolicyListQuery.new
    |> Repo.all(prefix: PrefixFormatter.get_current_prefix)
  end

  @doc """
  Gets a single policy.

  Raises `Ecto.NoResultsError` if the Policy does not exist.

  ## Examples

      iex> get_policy!(123)
      %Policy{}

      iex> get_policy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_policy!(id), do: Repo.get!(PolicySchema, id, prefix: PrefixFormatter.get_current_prefix)

  def get_policy!(id, year, month), do: Repo.get!(PolicySchema, id, prefix: PrefixFormatter.get_prefix(year, month))


  @doc """
  Creates a policy.

  ## Examples

      iex> create_policy(%{field: value})
      {:ok, %Policy{}}

      iex> create_policy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_policy(attrs \\ %{}) do
    %PolicySchema{}
    |> PolicySchema.changeset(attrs)
    |> Repo.insert(prefix: PrefixFormatter.get_current_prefix)
  end

  def create_policy(attrs \\ %{}, year, month, serial) do
    IO.inspect(attrs, label: "ATTTRSRRSSRSRSRSRSRSR::::::::::::::::::>>>>>>>>>>>>>>>>>>")
    ps = Map.put(attrs, "serial", serial.serial)
          |> Map.put("policy_number", serial.number)
          |> Map.put("audited", check_to_bool(attrs, "audited"))
          |> Map.put("has_documents", check_to_bool(attrs, "has_documents"))
          |> IO.inspect(label: "PPPPPPPPPPPSSSSSSSSSSSSSSSS:::::::::::::::>>>>>>>>>>>>>>>")
    %PolicySchema{}
    |> PolicySchema.changeset(GenericFunctions.string_map_to_atom(ps))
    |> Repo.insert(prefix: PrefixFormatter.get_prefix(year, month))
  end

  @doc """
  Updates a policy.

  ## Examples

      iex> update_policy(policy, %{field: new_value})
      {:ok, %Policy{}}

      iex> update_policy(policy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_policy(%PolicySchema{} = policy, attrs) do
    policy
    |> PolicySchema.changeset(attrs)
    |> Repo.update(prefix: PrefixFormatter.get_current_prefix)
  end

  def update_policy(%PolicySchema{} = policy, attrs, year, month) do
    policy
    |> PolicySchema.changeset(attrs)
    |> Repo.update(prefix: PrefixFormatter.get_prefix(year, month))
  end

  @doc """
  Deletes a policy.

  ## Examples

      iex> delete_policy(policy)
      {:ok, %Policy{}}

      iex> delete_policy(policy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_policy(%PolicySchema{} = policy) do
    Repo.delete(policy, prefix: PrefixFormatter.get_current_prefix)
  end

  def delete_policy(%PolicySchema{} = policy, year, month) do
    Repo.delete(policy, prefix: PrefixFormatter.get_prefix(year, month))
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking policy changes.

  ## Examples

      iex> change_policy(policy)
      %Ecto.Changeset{source: %Policy{}}

  """
  def change_policy(%PolicySchema{} = policy) do
    PolicySchema.changeset(policy, %{})
  end

  #************************************************************************************************************************************

  defp check_to_bool(params, where) do
    if(params[where] == "checked" , do: "true", else: "false")
  end

  def save_policy(params, arr) do
    Repo.transaction(fn() ->
      case save_all(params, arr) do
        {:ok, policy} ->
          policy
        {:error, reason} ->
          {Repo.rollback({:error, reason})}
      end
    end)
  end

  defp save_all(params, auxiliaries) do
    serial = SeriesHandler.get_serial(Map.get(params, "fiscal_exercise"), Map.get(params, "policy_type"))
    case AccountingSystem.PolicyHandler.create_policy(params, PolicyFormatter.get_year(params), PolicyFormatter.get_month(params), serial) do
      {:ok, policy} ->
        Enum.each(auxiliaries, fn x ->
          AuxiliaryHandler.create_auxiliary(AuxiliaryHandler.format_to_save(x, policy.policy_number, policy.id),
          PolicyFormatter.get_year(params),
          PolicyFormatter.get_month(params))
        end)
        {:ok, policy}
      {:error, reason} ->
        {:error, reason}
    end
  end

  def delete_policy_with_aux(id) do
    polly = get_policy!(id)
    auxiliaries = AccountingSystem.GetAllId.from_policy(String.to_integer(id)) |> Repo.all(prefix: PrefixFormatter.get_current_prefix)
    Repo.transaction(fn() ->
      case delete_all(polly, auxiliaries) do
        :ok ->
          :ok
        _ ->
          {Repo.rollback(:error)}
      end
    end)
  end

  defp delete_all(polly, auxiliaries) do
    case delete_policy(polly)  do
      {:ok, _} ->
        Enum.each(auxiliaries, fn id_aux -> AccountingSystem.AuxiliaryHandler.get_auxiliary!(Integer.to_string(id_aux)) |> AccountingSystem.AuxiliaryHandler.delete_auxiliary end)
      _ ->
        :error
    end
  end
end
