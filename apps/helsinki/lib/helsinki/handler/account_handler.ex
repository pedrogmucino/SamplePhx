defmodule AccountingSystem.AccountHandler do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.AccountSchema
  alias AccountingSystem.AccountCodeSchema
  alias AccountingSystem.CodeFormatter

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(AccountSchema)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(AccountSchema, id)

  def get_account_code!(id), do: Repo.get!(AccountCodeSchema, id)

  def get_principal_account!(), do: Repo.all(from acc in AccountCodeSchema, where: acc.level == 0, order_by: [desc: acc.id], limit: 1)


  def get_codes!(id) do
    iid = String.to_integer(id)
    from(acc in "accounts", where: acc.id == ^iid, select: [:code, :level, :root_account])
      |> Repo.all()
  end

  def get_last_child(id) do
    #Obtiene el ultimo hijo + 1
    from(c in "accounts", where: c.parent_account == ^id, select: [:code], order_by: [desc: :code], limit: 1)
      |> Repo.all
  end


  def get_next_code([%{code: codigo}]) do
    codigo
      |> CodeFormatter.add_in_position(0)
  end

  def get_config() do
    from(all in "structures", select: [:size, :level], order_by: [asc: :level])
      |> Repo.all
  end
  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %AccountSchema{}
    |> AccountSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%AccountSchema{} = account, attrs) do
    account
    |> AccountSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%AccountSchema{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%AccountSchema{} = account) do
    AccountSchema.changeset(account, %{})
  end

  def change_account_code(%AccountCodeSchema{} = account) do
    AccountCodeSchema.changeset(account, %{})
  end
end
