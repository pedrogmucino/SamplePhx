defmodule AccountingSystem.GetStructureList do
  @moduledoc """
  Módulo que obtiene la lista de estructuras ordenada por nivel
  """

  import Ecto.Query
  alias AccountingSystem.StructureSchema

  def new do
    from s in StructureSchema,
    order_by: [s.level]
  end
end
