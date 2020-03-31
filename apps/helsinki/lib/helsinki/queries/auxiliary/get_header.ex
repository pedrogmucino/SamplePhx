defmodule AccountingSystem.GetHeaderQuery do
  @moduledoc """
  Query para consultar el header de la consulta de auxiliares
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliarySchema
  }

  def header() do
    query =
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
    }

    from a in subquery(query),
    group_by: [:code, :name, :type],
    order_by: :code,
    select: %{
      code: a.code,
      name: a.name,
      type: a.type,
      debe: fragment("sum(debe)"),
      haber: fragment("sum(haber)")
    }
  end
end
