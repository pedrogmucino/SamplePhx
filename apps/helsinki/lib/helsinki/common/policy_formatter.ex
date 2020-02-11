defmodule AccountingSystem.PolicyFormatter do

  def get_necesaries() do
    %AccountingSystem.PolicyTypeSchema{}
      |> Map.put(:policy_type, AccountingSystem.PolicyTipeHandler.get_all_as_list)
      |> Map.put(:id_account1, AccountingSystem.AccountHandler.get_all_as_list)
  end

end
