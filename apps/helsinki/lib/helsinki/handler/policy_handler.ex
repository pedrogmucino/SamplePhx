defmodule AccountingSystem.PolicyHandler do
  @moduledoc """
  The Policies context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.{
    PolicySchema,
    PrefixFormatter,
    Repo
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
end
