defmodule AccountingSystem.GetMaxGeneralLevelQuery do
  @moduledoc """
  Módulo que contiene el query para consultar la estructura del máximo nivel de cuentas
  """
  import Ecto.Query, warn: false

  def new() do
    from str in "structures", select: max(str.level)
  end
end
