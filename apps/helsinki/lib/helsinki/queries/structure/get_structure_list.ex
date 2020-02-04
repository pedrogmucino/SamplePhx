defmodule AccountingSystem.GetStructureList do

  import Ecto.Query
  alias AccountingSystem.StructureSchema

  def new do
    from s in StructureSchema,
    order_by: [s.level]
  end
end
