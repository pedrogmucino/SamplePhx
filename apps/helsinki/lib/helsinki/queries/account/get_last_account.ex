defmodule AccountingSystem.GetLastAccount do
  import Ecto.Query
  alias AccountingSystem.AccountSchema

  def new(level) do
    from a in AccountSchema,
    where: a.level == ^level,
    order_by: [desc: fragment("split_part((?), '-', (?))", a.code, ^level + 1)],
    limit: 1,
    select: %{
      code: a.code
    }
  end
end
