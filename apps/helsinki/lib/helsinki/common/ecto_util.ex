defmodule AccountingSystem.EctoUtil do
  @moduledoc """
  Módulo para convertir lista de errores de ecto en un string con formato
  """
  def get_errors(changeset) do
    get_errors(changeset.errors, "")
  end

  defp get_errors([], error) do
    error
  end

  defp get_errors([{atom, {message, _array}} | tail], error) do
    get_errors(tail, error <> "#{atom}: #{message}<br>")
  end

end
