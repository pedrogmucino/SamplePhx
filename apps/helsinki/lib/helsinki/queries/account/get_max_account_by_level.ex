defmodule AccountingSystem.GetMaxAccountByLevel do

  import Ecto.Query
  alias AccountingSystem.AccountSchema

  def root_level(level) do
    from a in AccountSchema,
    where: a.level == ^level,
    select: fragment("max(split_part((?), '-', (?)))", a.code, ^level + 1)
  end

  def child_level(level, id) do
    from a in AccountSchema,
    where: a.level == ^level and a.parent_account == ^id,
    select: fragment("max(split_part((?), '-', (?)))", a.code, ^level + 1)
  end
end
