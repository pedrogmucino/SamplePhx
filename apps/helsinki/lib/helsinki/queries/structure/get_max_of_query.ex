defmodule AccountingSystem.GetMaxOf do
  import Ecto.Query, warn: false

  def get_max_level(level) do
    from str in "structures", select: [:max_current_size], where: str.level == ^level
  end
end
