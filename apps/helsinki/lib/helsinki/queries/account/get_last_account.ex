defmodule AccountingSystem.GetLastAccount do
  @moduledoc """
  Módulo con el query para obtener la cuenta con mayor código por nivel
  """
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
