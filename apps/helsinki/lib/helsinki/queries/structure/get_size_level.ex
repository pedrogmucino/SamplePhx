defmodule AccountingSystem.GetSizeLevel do
  import Ecto.Query, warn: false

  def size_level() do
    from(all in "structures", select: [:size, :level], order_by: [asc: :level])
  end

end
