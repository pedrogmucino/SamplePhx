defmodule AccountingSystem.ActiveAccounts do
  import Ecto.Query
  alias AccountingSystem.AccountSchema

  def get_all() do
    from acc in AccountSchema,
    where: acc.status == ^"A",
    select: [acc.id, acc.code, acc.description, acc.parent_account, acc.root_account],
    order_by: [acc.code]
  end

end