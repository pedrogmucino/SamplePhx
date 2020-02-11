defmodule AccountingSystem.AuxiliaryHandler do
  @moduledoc """
  The Auxiliaries context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliarySchema,
    PrefixFormatter,
    Repo
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
end
