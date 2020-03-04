
defmodule AccountingSystem.PolicyListQuery do
  import Ecto.Query, warn: false
  alias AccountingSystem.{
    PolicySchema,
    PolicyTypeSchema,
    PrefixFormatter
  }

  def new() do
    from p in "policies",
    join: t in PolicyTypeSchema,
    prefix: "public",
    on: p.policy_type == t.id,
    select: %{
      id: p.id,
      policy_number: p.policy_number,
      policy_type: p.policy_type,
      period: p.period,
      fiscal_exercise: p.fiscal_exercise,
      policy_date: p.policy_date,
      concept: p.concept,
      has_documents: p.has_documents,
      serial: p.serial,
      type_description: t.name,
      status: p.status
    },
    order_by: [desc: p.inserted_at]
  end
end
