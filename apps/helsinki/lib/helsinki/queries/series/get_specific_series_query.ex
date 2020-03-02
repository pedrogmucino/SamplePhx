defmodule AccountingSystem.GetSpecificSeriesQuery do
  import Ecto.Query
  alias AccountingSystem.{
    SeriesSchema,
    PolicyTypeSchema
  }

  def new(id) do
    from s in SeriesSchema,
    join: t in PolicyTypeSchema,
    on: s.policy_type_id == t.id,
    where: s.id == ^id,
    select: %{
      id: s.id,
      serial: s.serial,
      fiscal_exercise: s.fiscal_exercise,
      current_number: s.current_number,
      type: t.name
    }
  end
end
