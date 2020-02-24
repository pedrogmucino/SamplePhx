defmodule AccountingSystem.GetMaxGeneralLevelQuery do
  import Ecto.Query, warn: false

  def new() do
    from str in "structures", select: max(str.level)
  end
end
