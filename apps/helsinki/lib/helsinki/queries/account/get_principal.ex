defmodule AccountingSystem.GetPrincipal do
  import Ecto.Query, warn: false

  def account() do
    from acc in AccountingSystem.AccountCodeSchema, where: acc.level == 0, order_by: [desc: acc.id], limit: 1
  end

end
