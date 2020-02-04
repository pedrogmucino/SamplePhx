defmodule AccountingSystem.GetAccountList do

  import Ecto.Query
  alias AccountingSystem.AccountSchema

  def new do
    from a in AccountSchema,
    order_by: [a.code]
  end
end
