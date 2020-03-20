defmodule AccountingSystem.GetAllIdCode do
  @moduledoc """
  Módulo que contiene el query para obtener una lista ordenada de códigos de cuenta
  """
  import Ecto.Query, warn: false

  def id_code() do
    from x in "accounts",
      select: %{key: [x.code, " ", x.description], value: x.id},
      order_by: [x.code]
  end
end
