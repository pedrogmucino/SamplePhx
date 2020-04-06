defmodule AccountingSystem.GenericFunctions do
  @moduledoc """
  Módulo para funciones genéricas
  """
  def string_map_to_atom(map) do
    for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}
  end

  def to_float(x) when is_bitstring(x), do: void(x)
  def to_float(x) when is_integer(x), do: x / 1
  def to_float(x) when is_float(x), do: x
  def to_float(nil), do: 0.0
  defp void(0), do: 0.0
  defp void(some) do
    check_value(Regex.match?(~r/^[0-9][.][0-9]/, some), some)
  end
  defp check_value(false, _), do: 0
  defp check_value(true, some) do
    some
      |> Float.parse
      |> Tuple.to_list
      |> List.first
  end

  def to_bool(text), do: text == "true"

  def to_string_empty, do: ""

  def to_binary_empty, do: <<>>

  def string_concat(text_a, text_b), do: text_a <> text_b

end
