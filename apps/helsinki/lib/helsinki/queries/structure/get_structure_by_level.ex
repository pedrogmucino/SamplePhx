defmodule AccountingSystem.GetStructureByLevel do
  import Ecto.Query

  alias AccountingSystem.StructureSchema

  def new(level) do
    from s in StructureSchema,
    where: s.level == ^level
  end

end
