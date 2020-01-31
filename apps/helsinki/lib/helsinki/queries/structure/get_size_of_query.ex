defmodule AccountingSystem.GetSizeOf do

  import Ecto.Query, warn: false

  def size_of(level) do
    from(str in "structures", select: [:size], where: str.level == ^level)
  end
end
