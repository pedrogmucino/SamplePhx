defmodule AccountingSystem.GetHeaderQuery do
  @moduledoc """
  Query para consultar el header de la consulta de auxiliares
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliarySchema
  }

  def header() do
    from aux in AuxiliarySchema,
    join: policy in "policies",
    on: aux.policy_id == policy.id,
    join: acc in "accounts",
    prefix: "public",
    on: aux.id_account == acc.id,
    join: type in "policytypes",
    prefix: "public",
    on: policy.policy_type == type.id,
    group_by: [acc.code, acc.name, acc.type, aux.debit_credit],
    select: %{
      code: acc.code,
      name: acc.name,
      type: acc.type,
      debit_credit: aux.debit_credit,
      debe: fragment("case when debit_credit = ? then SUM(amount) else 0 end", "D"),
      haber: fragment("case when debit_credit = ? then SUM(amount) else 0 end", "H")
    },
    order_by: [acc.code, aux.debit_credit]
  end
end
