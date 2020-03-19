defmodule AccountingSystem.GenericFunctions do
  @moduledoc """
  Módulo para funciones genéricas
  """
  def string_map_to_atom(map) do
    for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}
  end
end
