defmodule AccountingSystem.PolicyFormatter do

  def get_necesaries() do
    %AccountingSystem.PolicyTypeSchema{}
      |> Map.put(:policy_type, AccountingSystem.PolicyTipeHandler.get_all_as_list)
      |> Map.put(:id_account1, AccountingSystem.AccountHandler.get_all_as_list)
  end

  def get_month(%{"policy_date" => policy}) do
    policy
      |> String.split("-")
      |> Enum.at(1)
      |> String.to_integer
  end

  def get_year(%{"policy_date" => policy}) do
    policy
    |> String.split("-")
    |> Enum.at(0)
    |> String.to_integer
  end

  def get_day(%{"policy_date" => policy}) do
    policy
    |> String.split("-")
    |> Enum.at(2)
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
