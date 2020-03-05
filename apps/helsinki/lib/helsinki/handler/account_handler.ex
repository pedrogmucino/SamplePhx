defmodule AccountingSystem.AccountHandler do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.{
    AccountSchema,
    AccountCodeSchema,
    GetAccountList,
    GetStructureByLevel,
    StructureSchema,
    GetLastAccount
  }

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    GetAccountList.new
    |> Repo.all
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

  def get_principal_account!() do
    AccountingSystem.GetPrincipal.account
      |> Repo.all
      |> List.first
  end

  def get_last_child(id) do
    #Obtiene el ultimo hijo
    AccountingSystem.GetLastChild.last_child(id)
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
    attrs
    |> update_structure

    %AccountSchema{}
    |> AccountSchema.changeset(attrs)
    |> Repo.insert()
  end

  defp update_structure(attrs) do
    attrs
    |> get_level
    |> GetStructureByLevel.new
    |> Repo.one!
    |> update_max_current_size(attrs)
  end

  defp get_level(attrs) do
    Map.get(attrs, "level")
  end

  defp update_max_current_size(%StructureSchema{} = structure, attrs) do
    level_size =
    attrs
    |> get_level_size

    str_max =
    Map.get(structure, :max_current_size)

    if level_size > str_max do
        StructureSchema.changeset(structure, %{"max_current_size" => level_size})
        |> Repo.update
    end

  end

  defp get_level_size(attrs) do
    attrs
    |> Map.get("code")
    |> String.split("-")
    |> Enum.at(Map.get(attrs, "level") |> String.to_integer)
    |> String.to_integer
    |> Integer.to_string
    |> String.length
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
    attrs
    |> update_structure

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
    update_structure_on_delete(account)
  end

  defp update_structure_on_delete(%AccountSchema{} = account) do
    try do
      account.level
      |> GetLastAccount.new
      |> Repo.one!
      |> Map.get(:code)
      |> get_max_size_on_delete(account)

    rescue
      Ecto.NoResultsError ->
        update_structure_decrease(true, 0, %{"code" => account.code, "level" => Integer.to_string(account.level)})
    end
  end

  defp get_max_size_on_delete(code, %AccountSchema{} = account) do
    %{"code" => code, "level" => Integer.to_string(account.level)}
    |> get_level_size
    |> get_level_size_on_delete(%{"code" => account.code, "level" => Integer.to_string(account.level)})

  end

  defp get_level_size_on_delete(max_size, attrs) do
    account_size =
    get_level_size(attrs)
    update_structure_decrease(account_size > max_size, max_size, attrs)
  end

  defp update_structure_decrease(true, max_size, attrs) do
    attrs
    |> get_level
    |> GetStructureByLevel.new
    |> Repo.one!
    |> update_structure_decrease_execute(max_size)
  end

  defp update_structure_decrease(false, _max_size, attrs) do
    {:ok, attrs}
  end

  defp update_structure_decrease_execute(%StructureSchema{} = structure, max_size) do
    StructureSchema.changeset(structure, %{"max_current_size" => max_size})
    |> Repo.update
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

  def get_all_as_list() do
    AccountingSystem.GetAllIdCode.id_code
      |> Repo.all
  end

  def list_of_childs(level, id_account) do
    AccountingSystem.GetChilds.of(id_account, level + 1)
      |> Repo.all
  end

  def get_from_strings(words) do
    AccountingSystem.SearchAccount.search_from_text(words)
      |>Repo.all
  end

  def search_account(word) do
    AccountingSystem.SearchAccount.search(word)
        |> AccountingSystem.Repo.all
  end

  def search_detail_account(word) do
    AccountingSystem.SearchAccount.search_detail_account(word)
    |> Repo.all
  end

  def get_description_by_id(id) do
    AccountingSystem.GetDescription.get_by_id(id)
      |> Repo.all
      |> List.first
  end

  def rfc_validation(rfc) do
    String.match?(rfc, ~r/^[[:alpha:]]{3,4}[[:digit:]]{6}[[:alnum:]]{3}+$/)
  end
end
