defmodule AccountingSystem.GetPolicySerialQuery do
  import Ecto.Query
  alias AccountingSystem.{
    SeriesSchema
  }

  def new(fiscal_exercise, policy_type) do
    from s in SeriesSchema,
    where: s.fiscal_exercise == ^fiscal_exercise
    and s.policy_type_id == ^policy_type,
    select: %{
      id: s.id,
      current_number: s.current_number,
      serial: s.serial
    }
  end
end
