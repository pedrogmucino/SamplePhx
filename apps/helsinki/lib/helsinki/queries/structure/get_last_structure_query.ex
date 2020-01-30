defmodule AccountingSystem.GetLastStructureQuery do

  alias AccountingSystem.StructureHandler
  alias AccountingSystem.StructureSchema
  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  def last_structure() do
    from(struc in "structures", select: [:size, :level, :max_current_size], order_by: [desc: :level], limit: 1)
      |> Repo.all
  end
end
