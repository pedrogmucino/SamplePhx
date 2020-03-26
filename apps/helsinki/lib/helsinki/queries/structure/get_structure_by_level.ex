defmodule AccountingSystem.GetStructureByLevel do
  @moduledoc """
  Módulo que obtiene el esquema de una estructura de determinado nivel
  """
  import Ecto.Query

  alias AccountingSystem.StructureSchema

  def new(level) do
    from s in StructureSchema,
    where: s.level == ^level
  end

end
