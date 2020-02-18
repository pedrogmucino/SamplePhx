defmodule AccountingSystem.GenericFunctions do
  def string_map_to_atom(map) do
    for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}
  end
end
