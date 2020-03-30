defmodule AccountingSystem.GetLastChild do
  @moduledoc """
  Query para obtener la cuenta hijo con mayor código de un padre
  """
  import Ecto.Query

  def last_child(id) do
    from(c in "accounts", where: c.parent_account == ^id, select: [:code], order_by: [desc: :code], limit: 1)
  end
end
