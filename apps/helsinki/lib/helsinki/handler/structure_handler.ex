defmodule AccountingSystem.StructureHandler do
  @moduledoc """
  The Structures context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.{
    StructureSchema,
    GetStructureList,
    CodeFormatter,
    GetMostRecentStructureQuery,
    GetMaxGeneralLevelQuery
  }
  alias AccountingSystem.GetSetAccountsCodes, as: AccountsGetSet
  # alias AccountingSystem.CodeFormatter


  def new_structure(nil) do
    %StructureSchema{}
      |> Map.put(:level, 0)
      |> Map.put(:max_current_size, 0)
  end

  def new_structure(structure) do
    %StructureSchema{}
      |> Map.put(:level, Map.get(structure, :level) + 1)
      |> Map.put(:max_current_size, 0)
  end

  def update_code_size(%{size: size, level: level}, %{"size" => new_size}) do
    eval = String.to_integer(new_size) - size
    update_execute(eval, level)
  end

  defp update_execute(0, _), do: :ok

  defp update_execute(length, level) when length < 0 do   #Si el cambio fue a Codigo mas CHICO (Quitar ceros)
    case check_if_you_can_delet_zeros(level, length * -1) do
      {:ok} ->
        AccountsGetSet.get_code_and_id
          |> Enum.each(fn data -> reduce_db_code(data, level, length * -1) end)
      {:error} ->
        {:error}
      end
  end

  defp update_execute(length, level) when length > 0 do  #Si el cambio fue a Codigo mas grande (cuantos '0' agregas, donde agregas osea en que nivel)
    AccountsGetSet.get_code_and_id
      |> Enum.each(fn data -> change_db_code(data, level, length) end)
  end

  defp check_if_you_can_delet_zeros(level, length) do
    level_size = AccountingSystem.GetSizeOf.size_of(level) |> Repo.all |> List.first |> Map.get(:size)
    max_current = AccountingSystem.GetMaxOf.get_max_level(level) |> Repo.all |> List.first |> Map.get(:max_current_size)
    case (level_size - max_current) >= length do
      true ->
        {:ok}
      false ->
        {:error}
    end

  end

  defp change_db_code(%{code: code, id: id}, level, length) do
    code
      |> CodeFormatter.string_to_list
      |> List.replace_at(level, CodeFormatter.string_to_list(code)
        |> Enum.at(level)
        |> CodeFormatter.add_zeros_at_left(length))
      |> CodeFormatter.list_to_string
      |> AccountsGetSet.set_new_code(id)
  end

  defp reduce_db_code(%{code: code, id: id}, level, length) do #Length = Cuantos ceros a la izquierda voy a quitar
    code
      |> CodeFormatter.string_to_list
      |> List.replace_at(level, CodeFormatter.string_to_list(code)
        |> Enum.at(level)
        |> CodeFormatter.try_quit_zeros(length))
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
    GetStructureList.new
    |> Repo.all
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

  def get_last_structure do
    GetMostRecentStructureQuery.new
    |> Repo.one!
  end

  @doc """
  Creates a structure.

  ## Examples

      iex> create_structure(%{field: value})
      {:ok, %Structure{}}

      iex> create_structure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_structure(attrs \\ %{}) do
    add_structure_to_codes(attrs)
    %StructureSchema{}
    |> StructureSchema.changeset(attrs)
    |> Repo.insert()
  end

  defp add_structure_to_codes(%{"size" => size}) do
    AccountingSystem.GetSetAccountsCodes.get_code_and_id()
      |> Enum.each(fn x -> update_code(x, size) end)
  end

  defp update_code(%{code: code, id: id}, size) do
    CodeFormatter.update_string(code, String.to_integer(size))
      |> AccountingSystem.GetSetAccountsCodes.set_new_code(id)
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
    case delet_self_and_childs(structure) do
      :ok ->
        {:ok}
      {:error} ->
        {:error}
    end
  end

  defp delet_self_and_childs(%{max_current_size: max_current_size}) when max_current_size > 0 do
    {:error}
  end

  defp delet_self_and_childs(%{level: level, max_current_size: max_current_size}) when max_current_size == 0 do
    max = AccountingSystem.GetChildVoid.get_max(level) |> Repo.all |> List.first
    AccountingSystem.GetChildVoid.get_all(level, max)
      |> Repo.all
      |> Enum.each(fn x ->
        x
          |> Map.get(:id)
          |> get_structure!
          |> delet_dis
      end)
  end

  defp delet_dis(structure) do
    quit_zeros(structure)
    Repo.delete(structure)
  end

  defp quit_zeros(%{level: level}) do
    AccountsGetSet.get_code_and_id
      |> Enum.each(fn x -> destroy_zeros(x, level) end)
  end

  defp destroy_zeros(%{code: code, id: id}, level) do
    code
      |> CodeFormatter.quit_zeros_from(level)
      |> AccountsGetSet.set_new_code(id)
  end

  def get_max_level() do
    GetMaxGeneralLevelQuery.new
    |> Repo.one!
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

  def get_level_size(level) do
    AccountingSystem.GetSizeOf.size_of(level)
    |> Repo.one!
  end
end
