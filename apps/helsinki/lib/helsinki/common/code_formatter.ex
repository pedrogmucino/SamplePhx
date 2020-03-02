defmodule AccountingSystem.CodeFormatter do

  alias AccountingSystem.AccountHandler
  alias AccountingSystem.Repo

  def add_in_position(string, position) do
    string
      |> string_to_list
      |> Enum.at(position)
      |> is_nil
      |> plus_one(Enum.at(string |> string_to_list, position), string, position)
      |> insert_value(string, position)
      |> list_to_string()
  end

  defp add_line([head | tail]) do
    head <> add_line("-", tail)
  end

  defp add_line([]), do: ""

  def first_configuration do
    AccountingSystem.GetSizeLevel.size_level
      |> Repo.all
      |> get_config_as_list
      |> list_to_string
      |> add_in_position(0)
  end

  defp get_config_as_list(list) do
    for x <- list do
      String.duplicate("0", Map.get(x, :size))
    end
  end

  def list_to_string(code) do
    add_line(code)
  end

  defp plus_one(false, strCode, _string, _position) do
    len = String.length(strCode)
    strCode
    |> String.to_integer
    |> Kernel.+(1)
    |> Integer.to_string
    |> addZero(len)
  end

  defp plus_one(true, nil, string, position) do
    str_code =
    string
    |> string_to_list
    |> Enum.at(position - 1)

    len = String.length(str_code)
    str_code
    |> String.to_integer
    |> Kernel.+(1)
    |> Integer.to_string
    |> addZero(len)
  end

  def try_quit_zeros(string, length) do
    string
      |> String.to_integer
      |> Integer.to_string
      |> addZero(String.length(string) - length)
  end

  def get_max_size(level) do
    AccountingSystem.GetMaxOf.get_max_level(level)
      |> Repo.all
      |> List.first
      |> Map.get(:max_current_size)
  end

  def giveme_a_son(codeschema) do
    level = Map.get(codeschema, :level) + 1
    AccountHandler.get_last_child(Map.get(codeschema, :id))
      |> get_code_from_query(codeschema)
      |> add_in_position(level)
  end

  def get_parent_description(id) do
    AccountingSystem.GetFromParent.the_name(id)
      |>Repo.all
      |>List.first
  end

  defp get_code_from_query([%{code: codigo}], _codeschema) do
    codigo
  end

  defp get_code_from_query([], codeschema) do
    #EN caso de que el query de Null osea que no tenga hijos aún
    Map.get(codeschema, :code)
  end

  defp add_line("-", [head | tail]) do
    "-" <> head <> add_line("-", tail)
  end

  defp add_line("-", []), do: ""

  def addZero(str, len) do
    size = String.length(str)
    if len - size < 0, do: raise RuntimeError, message: "Configuración incorrecta, favor de revisar"
    String.duplicate("0",len - size) <> str
  end

  defp insert_value(string, list, position) do
    List.replace_at(string_to_list(list), position, string)
  end

  def string_to_list(code) do
    String.split(code, "-")
  end

  def add_zeros_at_left(code_string, length) do
    String.duplicate("0", length) <> code_string
  end

  def update_string(string, size) do
    zeros = addZero("", size)
    "#{string}-#{zeros}"
  end

  def quit_zeros_from(code, level) do
    code
      |> string_to_list
      |> List.delete_at(level)
      |> list_to_string()
  end

  def concat_names(account_params) do
    account_params
      |> Map.get_and_update("name", fn name -> {name, name <> Map.get(account_params, "name2")} end)
      |> extract_map_from_get_and_update
  end

  defp extract_map_from_get_and_update({_, map}), do: map
end
