defmodule AccountingSystem.AuxiliaryHandler do
  @moduledoc """
  The Auxiliaries context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.AuxiliarySchema

  @doc """
  Returns the list of auxiliaries.

  ## Examples

      iex> list_auxiliaries()
      [%Auxiliary{}, ...]

  """
  def list_auxiliaries do
    Repo.all(AuxiliarySchema)
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
  def get_auxiliary!(id), do: Repo.get!(AuxiliarySchema, id)

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
    |> Repo.insert()
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
    |> Repo.update()
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
    Repo.delete(auxiliary)
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
