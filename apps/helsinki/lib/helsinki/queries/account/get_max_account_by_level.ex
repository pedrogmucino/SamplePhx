defmodule AccountingSystem.GetMaxAccountByLevel do

  import Ecto.Query
  alias AccountingSystem.AccountSchema

  def root_level(level) do
    from a in AccountSchema,
    where: a.level == ^level,
    select: fragment("case when max(split_part((?), '-', (?))) is null then '0' else max(split_part((?), '-', (?))) end", a.code, ^level + 1, a.code, ^level + 1)
  end

  def child_level(level, id) do
    from a in AccountSchema,
    where: a.level == ^level and a.parent_account == ^id,
    select: fragment("case when max(split_part((?), '-', (?))) is null then '0' else max(split_part((?), '-', (?))) end", a.code, ^level + 1, a.code, ^level + 1)
  end
end
