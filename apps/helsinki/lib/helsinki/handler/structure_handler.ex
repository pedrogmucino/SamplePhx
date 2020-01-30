defmodule AccountingSystem.StructureHandler do
  @moduledoc """
  The Structures context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.StructureSchema
  alias AccountingSystem.GetSetAccountsCodes, as: AccountsGetSet
  alias AccountingSystem.CodeFormatter


  def new_structure(nil) do
    %StructureSchema{}
      |> Map.put(:level, 1)
      |> Map.put(:max_current_size, 1)
  end

  def new_structure(structure) do
    %StructureSchema{}
      |> Map.put(:level, Map.get(structure, :level) + 1)
      |> Map.put(:max_current_size, 1)
  end

  def update_code_size(%{size: size, level: level}, %{"size" => new_size}) do
    eval = String.to_integer(new_size) - size
    do_the_update_please(eval, level)
  end

  defp do_the_update_please(a, level) when a == 0 do
    IO.inspect(AccountsGetSet.get_code_and_id, label: "RESUUUUUUUUUUUUUULT")
  end

  defp do_the_update_please(a, level) when a < 0 do
    IO.inspect("Maior a UNO CHAAAAAAAAA")
  end

  defp do_the_update_please(length, level) when length > 0 do  #Si el cambio fue a Codigo mas grande (cuantos 0 agregas, donde agregas osea en que nivel)
    AccountsGetSet.get_code_and_id
      |> Enum.each(fn data -> change_db_code(data, level, length) end)
  end

  defp change_db_code(%{code: code, id: id}, level, length) do
    code
      |> CodeFormatter.string_to_list
      |> List.replace_at(level - 1, CodeFormatter.string_to_list(code)
        |> Enum.at(level - 1)
        |> CodeFormatter.add_zeros_at_left(length))
      |> CodeFormatter.list_to_string
      |> AccountsGetSet.set_new_code(id)
  end
  @doc """
  Returns the list of structures.

  ## Examples

      iex> list_structures()
      [%Structure{}, ...]

  """
  def list_structures do
    Repo.all(StructureSchema)
  end

  @doc """
  Gets a single structure.

  Raises `Ecto.NoResultsError` if the Structure does not exist.

  ## Examples

      iex> get_structure!(123)
      %Structure{}

      iex> get_structure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_structure!(id), do: Repo.get!(StructureSchema, id)

  @doc """
  Creates a structure.

  ## Examples

      iex> create_structure(%{field: value})
      {:ok, %Structure{}}

      iex> create_structure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_structure(attrs \\ %{}) do
    %StructureSchema{}
    |> StructureSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a structure.

  ## Examples

      iex> update_structure(structure, %{field: new_value})
      {:ok, %Structure{}}

      iex> update_structure(structure, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_structure(%StructureSchema{} = structure, attrs) do
    structure
    |> StructureSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a structure.

  ## Examples

      iex> delete_structure(structure)
      {:ok, %Structure{}}

      iex> delete_structure(structure)
      {:error, %Ecto.Changeset{}}

  """
  def delete_structure(%StructureSchema{} = structure) do
    Repo.delete(structure)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking structure changes.

  ## Examples

      iex> change_structure(structure)
      %Ecto.Changeset{source: %Structure{}}

  """
  def change_structure(%StructureSchema{} = structure) do
    StructureSchema.changeset(structure, %{})
  end
end
