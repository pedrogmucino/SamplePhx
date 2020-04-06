defmodule AccountingSystemWeb.BalanceComponent do
  @moduledoc """
  Componente con listado general de pólizas
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.AccountHandler, as: Account
  alias AccountingSystem.AuxiliaryHandler, as: Auxiliar
  alias AccountingSystem.CodeFormatter, as: Formatter
  alias AccountingSystem.GenericFunctions, as: Generic
  alias AccountingSystem.XlsxFunctions, as: Xlsx
  alias AccountingSystem.{
    EctoUtil,
    PolicyHandler
  }
  alias AccountingSystemWeb.NotificationComponent

  def mount(socket) do
    {:ok, socket}
  end

  #**************************************************CALCULATING BALANCE*****************************************************************************
  def do_balance(start_account, end_account, start_date, end_date) do
    a = get_balance(start_account, end_account, start_date, end_date)
          |> IO.inspect(label: "GET BALANCE-------------------------------->")
          |> Enum.map(fn acc -> do_something(acc) end)
          |> IO.inspect(label: "ENUM MAP-------------------------------->")
    a
  end

  defp do_something([]), do: []
  defp do_something(acc) do
    IO.inspect(acc, label: "ACCCCC-------------------------------->")
    new_acc = Map.put(acc, :childs, Enum.map(acc.childs, fn ch -> do_something(ch) end))
    IO.inspect(new_acc, label: "NEW ACC-------------------------------->")
    new_new_acc = Map.merge(new_acc, sum_debit_credit(new_acc.childs))
    IO.inspect(new_new_acc, label: "NEW NEWWWWWW ACC-------------------------------->")
    new_new_acc
  end

  defp sum_debit_credit([]), do: %{} |> IO.inspect(label: "SUM DEB CRED []----------->")
  defp sum_debit_credit(list), do: Enum.reduce(list, %{}, fn x, acc -> sum_maps(x, acc) end) |> IO.inspect(label: "SUM DEB CRED SOMETHING--------->")
  defp sum_maps(%{debit: v1, credit: v2}, %{debit: v3, credit: v4}), do: %{debit: v1 + v3, credit: v2 + v4}
  defp sum_maps(map, %{}), do: %{debit: map.debit, credit: map.credit}

  defp get_balance(start_account, end_account, start_date, end_date), do: debit_credit_to_tree(get_account_tree_range(start_account, end_account), get_debit_credit_detail(start_date, end_date, start_account, end_account))

  defp debit_credit_to_tree(tree, detail), do: Enum.map(tree, fn x -> add_detail(x, detail, Map.new()) end )
  defp add_detail([], detail, father), do: put_values_of(father, Enum.find(detail, fn db_info -> db_info.id == father.id end))
  defp add_detail(root, detail, _), do: simule_map_put(root, detail, root.childs)
  defp simule_map_put(root, detail, []), do: Map.merge(root, simule_enum_map([], detail, root))
  defp simule_map_put(root, detail, next), do: Map.put(root, :childs, simule_enum_map(next, detail, root))
  defp simule_enum_map([], detail, father), do: add_detail([], detail, father)
  defp simule_enum_map(childs, detail, _), do: Enum.map(childs, fn son -> add_detail(son, detail, nil) end )
  defp put_values_of(father, nil), do: father |> Map.put(:debit, 0.0) |> Map.put(:credit, 0.0)
  defp put_values_of(father, db_info), do: father |> Map.put(:debit, db_info.debe) |> Map.put(:credit, db_info.haber)

  defp get_account_tree() do
    all_active = Enum.map(Account.get_active_accounts(), fn acc -> tree_map(acc) end)
    all_active
      |> get_root_accounts
      |> Enum.map(fn acc -> get_childs(acc, all_active) end)
  end
  defp get_account_tree_range(start_account, end_account) do
    all_active = Enum.map(Account.get_active_accounts_range(start_account, end_account), fn acc -> tree_map(acc) end)
    all_active
      |> get_root_accounts
      |> Enum.map(fn acc -> get_childs(acc, all_active) end)
  end

  defp get_root_accounts(accounts), do: Enum.filter(accounts, fn acc -> acc.parent_account == -1 end)
  defp tree_map(root) do
    Map.new()
      |> Map.put(:id, Enum.at(root, 0))
      |> Map.put(:account, Enum.at(root, 1))
      |> Map.put(:description, Enum.at(root, 2))
      |> Map.put(:parent_account, Enum.at(root, 3))
      |> Map.put(:root_account, Enum.at(root, 4))
  end
  defp get_childs(_, []), do: []
  defp get_childs(root, accounts) do
    childs = Enum.filter(accounts, fn acc -> acc.parent_account == root.id end)
    no_childs = Enum.reject(accounts, fn acc -> acc.parent_account == root.id end)
    root |> Map.put(:childs, Enum.map(childs, fn acc -> get_childs(acc, no_childs) end))
  end

  def get_debit_credit_detail(start_date, end_date, start_account, end_account) do
    Auxiliar.get_aux_report(Date.from_iso8601!(start_date), Date.from_iso8601!(end_date), start_account, end_account)
  end
  #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^END OF CALCULATING BALANCE^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  def render(assigns) do
    #
  end
end
