defmodule AccountingSystem.GetSizeOf do
  @moduledoc """
  Módulo que consulta de tamaño de estructura de determinado nivel
  """

  import Ecto.Query, warn: false

  def size_of(level) do
    from(str in "structures", select: [:size], where: str.level == ^level)
  end
end
