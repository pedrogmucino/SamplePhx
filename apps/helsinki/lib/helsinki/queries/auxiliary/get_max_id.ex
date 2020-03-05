defmodule AccountingSystem.GetMaxId do
  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliarySchema
  }

  def by_policy_id(policy_id) do
    from aux in AuxiliarySchema, select: max(aux.id), where: aux.policy_id == ^policy_id
  end
end
