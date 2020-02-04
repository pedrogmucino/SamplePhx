defmodule AccountingSystem.GetLastIncrementValueQuery do
  import Ecto.Query, warn: false
  alias AccountingSystem.Repo
  def last_inc_val() do
    from(x in "accounts_id_seq", select: x.last_value)
      |> Repo.all
      |> List.first
  end
end
