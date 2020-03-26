defmodule AccountingSystem.GetMostRecentStructureQuery do
  @moduledoc """
  Módulo que obtiene la consulta la estructura de mayor nivel
  """
  import Ecto.Query, warn: false

  def new() do
    from(struct in "structures", select: [:id, :size, :level, :max_current_size], order_by: [desc: :level], limit: 1)
  end
end
