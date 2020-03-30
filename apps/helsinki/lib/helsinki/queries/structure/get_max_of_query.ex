defmodule AccountingSystem.GetMaxOf do
  @moduledoc """
  Módulo que contiene el query para consultar el tamaño máximo actual de una cuenta de determinado nivel
  """
  import Ecto.Query, warn: false

  def get_max_level(level) do
    from str in "structures", select: [:max_current_size], where: str.level == ^level
  end
end
