defmodule AccountingSystem.GetSeriesQuery do
  @moduledoc """
  Query para obtener una lista de series y folio actual de todos los tipos de póliza
  """
  import Ecto.Query
  alias AccountingSystem.{
    SeriesSchema,
    PolicyTypeSchema
  }

  def new do
    from s in SeriesSchema,
    join: t in PolicyTypeSchema,
    on: s.policy_type_id == t.id,
    select: %{
      id: s.id,
      serial: s.serial,
      fiscal_exercise: s.fiscal_exercise,
      current_number: s.current_number,
      name: t.name
    },
    order_by: [s.policy_type_id]
  end
end
