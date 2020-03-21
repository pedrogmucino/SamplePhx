defmodule AccountingSystem.GetAllId do
  @moduledoc """
  Módulo que contiene los queries para consultar los auxiliares de una póliza
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliarySchema,
    AccountSchema
  }

  def from_policy(policy_number) do
    from aux in "auxiliaries",
    join: pollys in "policies",
    on: pollys.id == ^policy_number and aux.policy_number == pollys.policy_number,
    select: aux.id
  end

  def get_auxiliary_by_policy_id(id) do
    from aux in AuxiliarySchema,
    join: ac in AccountSchema,
    prefix: "public",
    on: aux.id_account == ac.id,
    where: aux.policy_id == ^id,
    select: %{
      id: aux.id,
      policy_number: aux.policy_number,
      id_account: aux.id_account,
      aux_concept: aux.concept,
      debit_credit: aux.debit_credit,
      mxn_amount: aux.mxn_amount,
      amount: aux.amount,
      department: aux.department,
      counterpart: aux.counterpart,
      cost_center: aux.cost_center,
      group: aux.group,
      iduuid: aux.iduuid,
      exchange_rate: aux.exchange_rate,
      inserted_at: aux.inserted_at,
      updated_at: aux.updated_at,
      policy_id: aux.policy_id,
      account: ac.code,
      number: row_number() |> over(order_by: aux.id)
    }
  end

end
