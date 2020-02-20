defmodule AccountingSystem.PolicyFormatter do

  def get_necesaries() do
    %AccountingSystem.PolicyTypeSchema{}
      |> Map.put(:policy_type, AccountingSystem.PolicyTipeHandler.get_all_as_list)
      |> Map.put(:id_account1, AccountingSystem.AccountHandler.get_all_as_list)
  end

  def get_month(policy) do
    policy

      |> Map.get("policy_schema")
      |> Map.get("policy_date")
      |> Map.get("month")
      |> String.to_integer
  end

  def get_year(policy) do
    policy

      |> Map.get("policy_schema")
      |> Map.get("policy_date")
      |> Map.get("year")
      |> String.to_integer
  end

  def get_day(policy) do
    policy
      |> Map.get("policy_schema")
      |> Map.get("policy_date")
      |> Map.get("day")
      |> String.to_integer
  end

  def date_format(params) do
    #Convertir %{"day" => "1", "month" => "1", "year" => "2015"} a "01/01/2015"
    [get_year(params), get_month(params), get_day(params)]
      |> Enum.map(&to_string/1)
      |> Enum.map(&String.pad_leading(&1, 2, "0"))
      |> Enum.join("/")
  end
end
