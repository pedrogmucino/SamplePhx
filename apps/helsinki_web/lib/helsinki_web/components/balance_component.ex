defmodule AccountingSystemWeb.BalanceComponent do
  @moduledoc """
  Componente con listado general de pólizas
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.AccountHandler, as: Account
  alias AccountingSystem.AuxiliaryHandler, as: Auxiliar
  alias AccountingSystem.CodeFormatter, as: Formatter
  alias AccountingSystemWeb.NotificationComponent

  def mount(socket) do
    now = Date.utc_today
    today = "#{now.year}-#{Formatter.add_zero(Integer.to_string(now.month), 2)}-#{Formatter.add_zero(Integer.to_string(now.day), 2)}"
    {:ok, assign(socket, type: "1", period: 0, start_date: today, end_date: today, change: false, message: "", error: nil, balance: nil, period: AccountingSystem.PeriodHandler.list_periods(), period_id: "1", start_account: "", end_account: "", show_balance: false, accounts: Account.list_accounts())}
  end

  def handle_event("change_type", %{"type" => "1"}, socket) do
    {:noreply, assign(socket, type: "1", period: AccountingSystem.PeriodHandler.list_periods())}
  end

  def handle_event("change_type", %{"type" => "2"}, socket) do
    {:noreply, assign(socket, type: "2")}
  end

  def handle_event("change_period", %{"period" => period}, socket) do
    {:noreply, assign(socket, period_id: period)}
  end

  def handle_event("change_date", %{"start_date" => start_date}, socket) do
    compare_start(start_date, socket.assigns.end_date, socket)
  end
  def handle_event("change_date", %{"end_date" => end_date}, socket) do
    compare_end(socket.assigns.start_date, end_date, socket)
  end

  def handle_event("save_account", params, socket) do
    IO.inspect(params, label: "PARAMS SAVE ACCOUNTS---------------------------------------->")
    {:noreply, assign(socket, start_account: params["start_account"], end_account: params["end_account"])}
  end

  def handle_event("show_data", _, socket) do
    IO.inspect(socket.assigns, label: "SOOOOCKEEEET-------------------------------->")
    case socket.assigns.type do
      "1" ->
        by_period(socket)
      "2" ->
        {:noreply, assign(socket, show_balance: true, balance: balance_to_list(do_balance(socket.assigns.start_account, socket.assigns.end_account, socket.assigns.start_date, socket.assigns.end_date)))}
    end
  end

  def by_period(socket) do
    period = Enum.find(socket.assigns.period, fn pd -> socket.assigns.period_id == "#{pd.id}" end)
    {:noreply, assign(socket, show_balance: true, balance: balance_to_list(do_balance(socket.assigns.start_account, socket.assigns.end_account, sigil_to_date(period.start_date), sigil_to_date(period.end_date))))}
  end

  defp sigil_to_date(now) do
    "#{now.year}-#{Formatter.add_zero(Integer.to_string(now.month), 2)}-#{Formatter.add_zero(Integer.to_string(now.day), 2)}"
  end

  def compare_start(start_date, end_date, socket) when start_date <= end_date do
    {:noreply, assign(socket, start_date: start_date)}
  end

  def compare_start(_, _, socket) do
    NotificationComponent.set_timer_notification_error()
    {:noreply, assign(socket, error: "La fecha inicial no puede ser mayor a la final", change: !socket.assigns.change)}
  end

  def compare_end(start_date, end_date, socket) when start_date <= end_date do
    {:noreply, assign(socket, end_date: end_date)}
  end

  def compare_end(_, _, socket) do
    NotificationComponent.set_timer_notification_error()
    {:noreply, assign(socket, error: "La fecha final no puede ser menor a la inicial", change: !socket.assigns.change)}
  end

  def balance_to_list(balance) do
    Enum.map(balance, fn bal -> List.flatten(tree_to_list(bal)) end)
      |> List.flatten()
  end

  def tree_to_list([]) do
    []
  end
  def tree_to_list(tree) do
    childs = tree.childs
    new_tree = Map.put(tree, :childs, [])
    [new_tree] ++ Enum.map(childs, fn ch -> tree_to_list(ch) end)
  end
  #**************************************************CALCULATING BALANCE*****************************************************************************
  def do_balance(start_account, end_account, start_date, end_date) do
    a = get_balance(start_account, end_account, start_date, end_date)
          |> Enum.map(fn acc -> do_something(acc) end)
    a
  end

  defp do_something([]), do: []
  defp do_something(acc) do
    new_acc = Map.put(acc, :childs, Enum.map(acc.childs, fn ch -> do_something(ch) end))
    new_new_acc = Map.merge(new_acc, sum_debit_credit(new_acc.childs))
    new_new_acc
  end

  defp sum_debit_credit([]), do: %{}
  defp sum_debit_credit(list), do: Enum.reduce(list, %{}, fn x, acc -> sum_maps(x, acc) end)
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

  defp get_account_tree_range("", "") do
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
      |> Map.put(:type, Enum.at(root, 5))
      |> Map.put(:level, Enum.at(root, 6))
  end
  defp get_childs(_, []), do: []
  defp get_childs(root, accounts) do
    childs = Enum.filter(accounts, fn acc -> acc.parent_account == root.id end)
    no_childs = Enum.reject(accounts, fn acc -> acc.parent_account == root.id end)
    root |> Map.put(:childs, Enum.map(childs, fn acc -> get_childs(acc, no_childs) end))
  end

  def get_debit_credit_detail(start_date, end_date, "", "") do
    Auxiliar.get_aux_report(Date.from_iso8601!(start_date), Date.from_iso8601!(end_date))
  end
  def get_debit_credit_detail(start_date, end_date, "", end_account) do
    Auxiliar.get_aux_report(Date.from_iso8601!(start_date), Date.from_iso8601!(end_date), "0", end_account)
  end
  def get_debit_credit_detail(start_date, end_date, start_account, end_account) do
    Auxiliar.get_aux_report(Date.from_iso8601!(start_date), Date.from_iso8601!(end_date), start_account, end_account)
  end
  #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^END OF CALCULATING BALANCE^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  def render(assigns) do
    ~L"""
      <%= if @error do %>
        <%= live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "error_comp", message: @error, show: true, notification_type: "error", change: @change) %>
      <% end %>

      <div id="balance" class="bg-white h-hoch-93 w-80 mt-16 ml-16 block float-left">

        <div class="w-full py-2 bg-blue-700">
          <p class="ml-2 font-bold text-lg text-white">Balanza</p>
        </div>

        <div class="relative w-full px-2 mt-4">

          <div class="w-full">
            <b>Tipo</b>
          </div>

          <div class="w-full mt-1 flex">

            <div class="inline-block relative w-5/6">
              <form phx-target="#balance" phx-change="change_type">
                <select name="type" class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline">
                  <option id="1" value="1" <%= if @type == "1", do: 'selected' %> >Periodo</option>
                  <option id="2" value="2" <%= if @type == "2", do: 'selected' %> >Acumulado</option>
                </select>
              </form>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                  <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                </div>
            </div>
            <div class="w-1/6 text-right">
              <button phx-click="show_data" phx-target="#balance" class="tooltip">
                <label for="balance_all" class="custom-file-upload border w-10 bg-teal-500 rounded text-white hover:bg-teal-400">
                  <i class="fa fa-cloud-upload"></i>
                  <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="upload" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="h-6 w-6 -ml-1"><path fill="currentColor" d="M190.5 66.9l22.2-22.2c9.4-9.4 24.6-9.4 33.9 0L441 239c9.4 9.4 9.4 24.6 0 33.9L246.6 467.3c-9.4 9.4-24.6 9.4-33.9 0l-22.2-22.2c-9.5-9.5-9.3-25 .4-34.3L311.4 296H24c-13.3 0-24-10.7-24-24v-32c0-13.3 10.7-24 24-24h287.4L190.9 101.2c-9.8-9.3-10-24.8-.4-34.3z" class=""></path></svg>
                </label>
                <label id="balance_all"></label>
                <span class='tooltip-text font-light text-xs text-white bg-blue-500 mt-5 -ml-12 rounded'>Consultar Balanza</span>
                <iframe id="invisible" style="display:none;"></iframe>
              </button>
            </div>

          </div>

          <div class="w-full">
            <form phx-target="#balance" phx-change="save_account">
              <div class="w-full">
                <b>Cuenta Inicio</b>
              </div>

              <div class="w-full">
                <select name="start_account" class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline">
                  <%= for account <- @accounts do %>
                    <option id = "<%= account.id %>" value="<%= account.code %>" <%= if @start_account == "#{account.code}", do: 'selected' %> ><%= account.code <> " " <> account.description %> </option>
                  <% end %>
                </select>
              </div>

              <div class="w-full">
                <b>Cuenta Final</b>
              </div>

              <div class="w-full">
                <select name="end_account" class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline">
                  <%= for account <- @accounts do %>
                    <option id = "<%= account.id %>" value="<%= account.code %>" <%= if @end_account == "#{account.code}", do: 'selected' %> ><%= account.code <> " " <> account.description %> </option>
                  <% end %>
                </select>
              </div>
            </form>

          </div>

          <%= if @type == "1" do %>
            <div class="w-full mt-2">

              <div class="w-full">
                <b>Periodo</b>
              </div>

              <div class="w-full mt-1">
                <div class="inline-block relative w-full">
                  <form phx-target="#balance" phx-change="change_period">
                    <select name="period" class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline">
                      <%= for period <- @period do %>
                        <option value="<%= period.id %>" <%= if @period_id == "#{period.id}", do: 'selected' %> ><%= period.name %> </option>
                      <% end %>
                    </select>
                  </form>
                  <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                  </div>
                </div>
              </div>

            </div>
          <% end %>
          <%= if @type == "2" do %>
            <div class="w-full mt-2">

              <div class="w-full">
                <b>Fecha de inicio</b>
              </div>
              <form phx-target="#balance" phx-change="change_date">
                <div class="w-full mt-1">
                  <input name="start_date" type="date" class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 rounded shadow leading-tight focus:outline-none focus:shadow-outline" value="<%= @start_date %>">
                </div>
              </form>

              <div class="w-full mt-1">
                <b>Fecha Fin</b>
              </div>
              <form phx-target="#balance" phx-change="change_date">
                <div class="w-full mt-1">
                  <input name="end_date" type="date" class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 rounded shadow leading-tight focus:outline-none focus:shadow-outline" value="<%= @end_date %>">
                </div>
              </form>

            </div>
          <% end %>

        </div>
      </div>

    <%= if @show_balance do %>
      <%= live_component(@socket, AccountingSystemWeb.BalanceListComponent, id: "1", balance: @balance) %>
    <% end %>
    """
  end
end
