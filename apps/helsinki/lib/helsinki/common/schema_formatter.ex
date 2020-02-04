
defmodule AccountingSystem.SchemaFormatter do
  alias AccountingSystem.CodeFormatter
  alias AccountingSystem.GetLastIncrementValueQuery, as: AccountLastIncrement

  def get_child_values(code_schema) do
    id = Map.get(code_schema, :id)
    %AccountingSystem.AccountCodeSchema{}
      |> Map.put(:parent_account, id)
      |> Map.put(:code, CodeFormatter.giveme_a_son(code_schema))
      |> Map.put(:name, CodeFormatter.get_parent_description(id)<> "-")
      |> Map.put(:level, Map.get(code_schema, :level) + 1)
      |> Map.put(:root_account, Map.get(code_schema, :root_account))
    #Ste men saca el valor del hijo mayor y genera el codigo del siguiente hijo
  end

  def get_root_account(nil) do
    %AccountingSystem.AccountCodeSchema{}
    |> Map.put(:code, CodeFormatter.first_configuration())
    |> Map.put(:level, 0)
    |> Map.put(:parent_account, -1)
    |> Map.put(:root_account, AccountLastIncrement.last_inc_val + 1)
  end

  def get_root_account(schema) do
    %AccountingSystem.AccountCodeSchema{}
    |> Map.put(:code, CodeFormatter.add_in_position(Map.get(schema, :code), 0))
    |> Map.put(:level, 0)
    |> Map.put(:parent_account, -1)
    |> Map.put(:root_account, AccountLastIncrement.last_inc_val + 1)
  end

end
