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
    |> AuxiliarySchema.changeset(attrs)
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
    auxiliary
    |> AuxiliarySchema.changeset(attrs)
    |> Repo.update(prefix: PrefixFormatter.get_current_prefix)
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
      4 ->
        {:ok, params}
      _ ->
        {:error, params}

    end
  end

  defp are_complete(params) do #regresa la cantidad de valores no vacios de un mapa
    params
      |> Map.values
      |> Enum.reject(fn x -> x == "" end)
      |> Enum.count
  end

  def format_to_save(params, policy_number, policy_id) do
    params = Map.merge(params, %{"debit_credit" => h_or_d(params)})
    params = Map.merge(params, %{"mxn_amount" => amount(params)})
    params = Map.merge(params, %{"amount" => amount(params)})
    params = Map.merge(params, %{"exchange_rate" => 1})
    params = Map.merge(params, %{"policy_id" => policy_id})
    params = Map.merge(params, %{"policy_number" => policy_number})
    params = Map.delete(params, "haber")
    params = Map.delete(params, "debe")
    params = Map.delete(params, "id")
    GenericFunctions.string_map_to_atom(params)
  end

  def h_or_d(%{"haber" => hab}) do
    case hab do
      "" ->
        "D"
      _ ->
        "H"
    end
  end

  def amount(%{"haber" => hab}) when hab != "" do
    hab
  end

  def amount(%{"debe" => deb}) when deb != "" do
    deb
  end
end
