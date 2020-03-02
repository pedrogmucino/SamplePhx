defmodule AccountingSystem.PrefixFormatter do
  def get_current_prefix do
    current_date =
    Date.utc_today

    "period_" <> Integer.to_string(current_date.year) <> "_" <> Integer.to_string(current_date.month)

  end

  def get_prefix(year, month) do
    "period_" <> Integer.to_string(year) <> "_" <> Integer.to_string(month)
  end

end
