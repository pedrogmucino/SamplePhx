defmodule AccountingSystem.GetDescription do
  import Ecto.Query, warn: false
  alias AccountingSystem.AccountSchema

  def get_by_id(id) do
    from acc in AccountSchema, select: acc.description, where: acc.id == ^id
  end
end
