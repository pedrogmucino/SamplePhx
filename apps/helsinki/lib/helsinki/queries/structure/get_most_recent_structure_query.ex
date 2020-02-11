defmodule AccountingSystem.GetMostRecentStructureQuery do
  import Ecto.Query, warn: false

  def new() do
    from(struct in "structures", select: [:size, :level, :max_current_size], order_by: [desc: :level], limit: 1)
  end
end
