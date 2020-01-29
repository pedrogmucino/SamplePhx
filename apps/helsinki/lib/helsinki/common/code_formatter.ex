defmodule AccountingSystem.CodeFormatter do

  alias AccountingSystem.AccountHandler
  alias AccountingSystem.GetLastIncrementValueQuery, as: AccountLastIncrement

  def get_child_values(code_schema) do
    %AccountingSystem.AccountCodeSchema{}
      |> Map.put(:parent_account, Map.get(code_schema, :id))
      |> Map.put(:code, giveme_a_son(code_schema))
      |> Map.put(:level, Map.get(code_schema, :level) + 1)
      |> Map.put(:root_account, Map.get(code_schema, :root_account))
    #Ste men saca el valor del hijo mayor y genera el codigo del siguiente hijo
  end

  def get_root_account(nil) do
    %AccountingSystem.AccountCodeSchema{}
    |> Map.put(:code, first_configuration())
    |> Map.put(:level, 0)
    |> Map.put(:parent_account, -1)
    |> Map.put(:root_account, AccountLastIncrement.last_inc_val + 1)
  end

  def get_root_account(schema) do
    %AccountingSystem.AccountCodeSchema{}
    |> Map.put(:code, add_in_position(Map.get(schema, :code), 0))
    |> Map.put(:level, 0)
    |> Map.put(:parent_account, -1)
    |> Map.put(:root_account, AccountLastIncrement.last_inc_val + 1)
  end

  def add_in_position(string, position) do
    string
      |>string_to_list
      |>Enum.at(position)
      |>plus_one
      |>insert_value(string, position)
      |>list_to_string()
  end

  defp add_line([head | tail]) do
    head <> add_line("-", tail)
  end

  defp add_line([]), do: ""

  defp first_configuration do
    AccountHandler.get_config()
    |> get_config_as_list
    |> list_to_string
    |> add_in_position(0)
  end

  defp get_config_as_list(list) do
    for x <- list do
      String.duplicate("0", Map.get(x, :size))
    end
  end

  defp list_to_string(code) do
    add_line(code)
  end

  defp plus_one(strCode) do
    len = String.length(strCode)
    strCode
      |>String.to_integer
      |>Kernel.+(1)
      |>Integer.to_string
      |>addZero(len)
  end

  defp giveme_a_son(codeschema) do
    level = Map.get(codeschema, :level) + 1
    AccountHandler.get_last_child(Map.get(codeschema, :id))
      |> get_code_from_query(codeschema)
      |> add_in_position(level)
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

  defp addZero(str, len) do
    size = String.length(str)
    String.duplicate("0",len - size) <> str
  end

  defp insert_value(string, list, position) do
    List.replace_at(string_to_list(list), position, string)
  end

  defp string_to_list(code) do
    String.split(code, "-")
  end

end
