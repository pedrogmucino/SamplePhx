defmodule AccountingSystem.CodeFormatter do

  def string_to_list(code) do
    String.split(code, "-")
  end

  def list_to_string(code) do
    add_line(code)
  end

  def plus_one(strCode) do
    len = String.length(strCode)
    strCode
      |>String.to_integer
      |>Kernel.+(1)
      |>Integer.to_string
      |>addZero(len)
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

end
