defmodule AccountingSystem.GetActiveAccountsQuery do
  @moduledoc """
  Módulo para obtener una lista ordenada de cuentas
  """

  import Ecto.Query
  alias AccountingSystem.AccountSchema

  def detail_accounts do
    from a in AccountSchema,
    where: a.status == "A"
    and a.type == "D",
    order_by: [a.code]
  end

  def detail_range_accounts(initial_account, final_account) do
    from a in AccountSchema,
    where: a.status == "A"
    and a.type == "D"
    and a.code >= ^initial_account
    and a.code <= ^final_account,
    order_by: a.code
  end
end
