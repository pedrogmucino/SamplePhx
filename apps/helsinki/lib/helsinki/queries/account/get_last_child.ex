defmodule AccountingSystem.GetLastChild do
  import Ecto.Query
  alias AccountingSystem.AccountSchema

  def last_child(id) do
    from(c in "accounts", where: c.parent_account == ^id, select: [:code], order_by: [desc: :code], limit: 1)
  end
end
