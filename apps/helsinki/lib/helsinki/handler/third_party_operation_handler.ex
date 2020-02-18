defmodule AccountingSystem.ThirdPartyOperationHandler do
  @moduledoc """
  The ThirdPartyOperations context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.ThirdPartyOperationSchema

  @doc """
  Returns the list of thirdpartyoperations.

  ## Examples

      iex> list_thirdpartyoperations()
      [%ThirdPartyOperation{}, ...]

  """
  def list_thirdpartyoperations do
    Repo.all(ThirdPartyOperationSchema)
  end

  @doc """
  Gets a single third_party_operation.

  Raises `Ecto.NoResultsError` if the Third party operation does not exist.

  ## Examples

      iex> get_third_party_operation!(123)
      %ThirdPartyOperation{}

      iex> get_third_party_operation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_third_party_operation!(id), do: Repo.get!(ThirdPartyOperationSchema, id)

  @doc """
  Creates a third_party_operation.

  ## Examples

      iex> create_third_party_operation(%{field: value})
      {:ok, %ThirdPartyOperation{}}

      iex> create_third_party_operation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_third_party_operation(attrs \\ %{}) do
    %ThirdPartyOperationSchema{}
    |> ThirdPartyOperationSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a third_party_operation.

  ## Examples

      iex> update_third_party_operation(third_party_operation, %{field: new_value})
      {:ok, %ThirdPartyOperation{}}

      iex> update_third_party_operation(third_party_operation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_third_party_operation(%ThirdPartyOperationSchema{} = third_party_operation, attrs) do
    third_party_operation
    |> ThirdPartyOperationSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a third_party_operation.

  ## Examples

      iex> delete_third_party_operation(third_party_operation)
      {:ok, %ThirdPartyOperation{}}

      iex> delete_third_party_operation(third_party_operation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_third_party_operation(%ThirdPartyOperationSchema{} = third_party_operation) do
    Repo.delete(third_party_operation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking third_party_operation changes.

  ## Examples

      iex> change_third_party_operation(third_party_operation)
      %Ecto.Changeset{source: %ThirdPartyOperation{}}

  """
  def change_third_party_operation(%ThirdPartyOperationSchema{} = third_party_operation) do
    ThirdPartyOperationSchema.changeset(third_party_operation, %{})
  end
end
