defmodule AccountingSystem.GetMaxAccountByLevel do
  @moduledoc """
  Módulo que contiene el query que permite obtener el fragmento de código de una cuenta correspondiente a un nivel
  """

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
