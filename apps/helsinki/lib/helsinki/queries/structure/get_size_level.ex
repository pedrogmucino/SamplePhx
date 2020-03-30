defmodule AccountingSystem.GetSizeLevel do
  @moduledoc """
  Módulo de obtiene el tamaño y nivel e todas las estructura ordenadas por nivel
  """
  import Ecto.Query, warn: false

  def size_level() do
    from(all in "structures", select: [:size, :level], order_by: [asc: :level])
  end

end
