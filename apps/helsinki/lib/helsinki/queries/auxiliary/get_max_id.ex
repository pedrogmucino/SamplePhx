defmodule AccountingSystem.GetMaxId do
  @moduledoc """
  Módulo que contiene el query para consultar el último auxiliar registrado de una póliza
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.{
    AuxiliarySchema
  }

  def by_policy_id(policy_id) do
    from aux in AuxiliarySchema, select: max(aux.id), where: aux.policy_id == ^policy_id
  end
end
