defmodule AccountingSystem.GetChilds do
  @moduledoc """
  Módulo que contiene el query para obtener una lista de cuentas hijo de un parent
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.AccountSchema

  def of(parent, level) do
    from x in AccountSchema,
      where: x.level == ^level and x.parent_account == ^parent,
      order_by: [x.code]
  end
end
