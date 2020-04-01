defmodule AccountingSystem.PrefixFormatter do
  @moduledoc """
  Módulo para establecer prefix de tablas de pólizas y auxiliares
  """
  use Timex

  def get_current_prefix do
    current_date = Date.utc_today()

    "period_" <>
      Integer.to_string(current_date.year) <> "_" <> Integer.to_string(current_date.month)
  end

  def get_prefix(year, month) do
    "period_" <> Integer.to_string(year) <> "_" <> Integer.to_string(month)
  end

  def get_period_list(start_date, end_date) do
    {:ok, initial_date} = Date.new(start_date.year, start_date.month, 1)
    add_period([initial_date, end_date], [])
  end

  defp add_period([h | t], new_list) do
    if Date.compare(h, List.first(t)) == :lt do
      add_period(
        [Timex.shift(h, months: 1), List.first(t)],
        List.insert_at(new_list, 0, get_prefix(h.year, h.month))
      )
    else
      if Date.compare(h, List.first(t)) == :eq do
        add_period(
          [],
          List.insert_at(new_list, 0, get_prefix(h.year, h.month)))
      else
        add_period([], new_list)
      end
    end
  end

  defp add_period([], new_list), do: new_list |> Enum.reverse
end
