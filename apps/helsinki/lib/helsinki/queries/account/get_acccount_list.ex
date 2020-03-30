defmodule AccountingSystem.GetAccountList do
  @moduledoc """
  Módulo para obtener una lista ordenada de cuentas
  """

  import Ecto.Query
  alias AccountingSystem.AccountSchema

  def new do
    from a in AccountSchema,
    order_by: [a.code]
  end
end
