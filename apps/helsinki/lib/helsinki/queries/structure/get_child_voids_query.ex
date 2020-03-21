defmodule AccountingSystem.GetChildVoid do
  @moduledoc """
  Módulo que contiene los queries para consultar los id de estructuras de cuenta de determinado nivel
  """
  import Ecto.Query, warn: false

  def get_all(level, max) do
    from(str in "structures", select: [:id], where: str.level >= ^level and ^max == 0, order_by: [desc: str.level])
  end

  def get_max(level) do
    from(all in "structures", select: max(all.max_current_size), where: all.level >= ^level)
  end
end
