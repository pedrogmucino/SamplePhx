defmodule AccountingSystem.GetLastIncrementValueQuery do
  import Ecto.Query, warn: false
  alias AccountingSystem.Repo
  def last_inc_val() do
    Ecto.Adapters.SQL.query(Repo, "select * from accounts_id_seq")
      |> get_result
      |> Map.get(:rows)
      |> List.first
      |> List.first
  end

  defp get_result({:ok, map}), do: map

end
