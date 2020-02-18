defmodule AccountingSystem.PolicyTipeHandler do
  @moduledoc """
  The PolicyTipes context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.PolicyTypeSchema

  @doc """
  Returns the list of policytypes.

  ## Examples

      iex> list_policytypes()
      [%PolicyType{}, ...]

  """
  def list_policytypes do
    Repo.all(PolicyTypeSchema)
  end

  @doc """
  Gets a single policy_type.

  Raises `Ecto.NoResultsError` if the Policy type does not exist.

  ## Examples

      iex> get_policy_type!(123)
      %PolicyType{}

      iex> get_policy_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_policy_type!(id), do: Repo.get!(PolicyTypeSchema, id)

  @doc """
  Creates a policy_type.

  ## Examples

      iex> create_policy_type(%{field: value})
      {:ok, %PolicyType{}}

      iex> create_policy_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_policy_type(attrs \\ %{}) do
    %PolicyTypeSchema{}
    |> PolicyTypeSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a policy_type.

  ## Examples

      iex> update_policy_type(policy_type, %{field: new_value})
      {:ok, %PolicyType{}}

      iex> update_policy_type(policy_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_policy_type(%PolicyTypeSchema{} = policy_type, attrs) do
    policy_type
    |> PolicyTypeSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a policy_type.

  ## Examples

      iex> delete_policy_type(policy_type)
      {:ok, %PolicyType{}}

      iex> delete_policy_type(policy_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_policy_type(%PolicyTypeSchema{} = policy_type) do
    Repo.delete(policy_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking policy_type changes.

  ## Examples

      iex> change_policy_type(policy_type)
      %Ecto.Changeset{source: %PolicyType{}}

  """
  def change_policy_type(%PolicyTypeSchema{} = policy_type) do
    PolicyTypeSchema.changeset(policy_type, %{})
  end

  def get_all_as_list() do
    AccountingSystem.GetAllIdName.id_name()
      |> Repo.all
      |> Enum.map(fn x -> Map.to_list(x) end)
  end

  def get_types() do
    AccountingSystem.GetAllIdName.id_name()
      |> Repo.all
  end
end
