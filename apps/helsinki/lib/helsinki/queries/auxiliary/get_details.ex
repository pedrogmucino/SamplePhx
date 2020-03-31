defmodule AccountingSystem.GetDetailsQuery do
  @moduledoc """
  Query para consultar el header de la consulta de auxiliares
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliarySchema
  }

  def details(id) do
    from aux in AuxiliarySchema,
    join: policy in "policies",
    on: aux.policy_id == policy.id,
    join: acc in "accounts",
    prefix: "public",
    on: aux.id_account == acc.id,
    join: type in "policytypes",
    prefix: "public",
    on: policy.policy_type == type.id,
    where: acc.id == ^id,
    group_by: [
      type.name,
      policy.serial,
      policy.policy_number,
      policy.policy_date,
      acc.id,
      aux.amount,
      aux.concept,
      aux.debit_credit
      ],
    select: %{
      policy_type: type.name,
      serial: policy.serial,
      number: policy.policy_number,
      date: policy.policy_date,
      amount: aux.amount,
      auxiliary_type: aux.debit_credit,
      concept: aux.concept
    },
    order_by: [policy.policy_date]
  end
end
