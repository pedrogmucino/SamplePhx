defmodule AccountingSystem.GetPrincipal do
  @moduledoc """
  Módulo que contiene el query para la última cuenta registrada de nivel 0
  """
  import Ecto.Query, warn: false

  def account() do
    from acc in AccountingSystem.AccountCodeSchema, where: acc.level == 0, order_by: [desc: acc.id], limit: 1
  end

end
