defmodule AccountingSystemWeb.FormAuxiliariesComponent do
  @moduledoc """
  Componente Form Auxiliaries Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.PeriodHandler, as: Period
  alias AccountingSystem.AccountHandler, as: Account
  alias AccountingSystemWeb.NotificationComponent, as: Notification

  def mount(socket) do
    {:ok,
     assign(socket,
       list_auxiliaries: nil,
       details_accounts: join_none_details_accounts(get_details_accounts()),
       periods: join_none_period(get_periods()),
       period_selected: 0,
       account_from_selected: 0,
       account_from_selected_code: "",
       account_to_selected: 0,
       account_to_selected_code: "",
       start_date: "",
       end_date: "",
       error: nil
     )}
  end

  def update(_attrs, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div id="formauxiliaries" class="flex-none bg-white mt-16 ml-16 w-80 h-hoch-93 rounded border float-left">
        <div class="w-full py-2 bg-blue-700">
          <p class="ml-2 font-bold text-lg text-white">Auxiliares</p>
        </div>

          <div class="py-2">
            <p class="ml-2 font-bold text-lg text-black">Cuenta</p>
            <div class="m-2 border-solid border-2 border-gray-300 p-4 rounded">
              <label class="block"><b>Desde</b></label>
              <div class="relative mb-3">
                <select name="account_from" class="focus:outline-none focus:bg-white focus:border-blue-500 block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight" id="option-type">
                  <%= for item <- @details_accounts do %>
                    <option phx-target="#formauxiliaries" phx-click="account_from_chosen" value="<%= item.value %> <%= List.first(item.key)%>" <%= if @account_from_selected == item.value, do: 'selected' %> ><%= item.key %></option>
                  <% end %>
                </select>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                  <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                </div>
              </div>
              <label class="block"><b>Hasta</b></label>
              <div class="relative mb-3">
                <select name="account_to" class="focus:outline-none focus:bg-white focus:border-blue-500 block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight" id="option-type">
                  <%= for item <- @details_accounts do %>
                    <option phx-target="#formauxiliaries" phx-click="account_to_chosen" value="<%= item.value %> <%= List.first(item.key)%>" <%= if @account_to_selected == item.value, do: 'selected' %> ><%= item.key %></option>
                  <% end %>
                </select>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                  <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                </div>
              </div>
            </div>
          </div>

          <div class="py-2">
            <p class="ml-2 font-bold text-lg text-black">Periodo</p>
            <div class="m-2 border-solid border-2 border-gray-300 p-4 rounded">
              <label class="block"><b>Fecha Inicio</b></label>
              <form phx-change="start_date_chosen" phx-target="#formauxiliaries">
                <input type="date" name="start_date" value="<%= @start_date %>" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white">
              </form>
              <label class="block"><b>Fecha Fin</b></label>
              <form phx-change="end_date_chosen" phx-target="#formauxiliaries">
                <input type="date" name="end_date" value="<%= @end_date %>" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white">
              </form>
              <div class="mt-4 mb-4 -ml-4 -mr-4 border-t-2 border-gray-300"></div>
              <label class="block"><b>Periodo</b></label>
              <div class="relative mb-3">
                <select name="period" class="focus:outline-none focus:bg-white focus:border-blue-500 block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight" id="option-type">
                  <%= for item <- @periods do %>
                    <option phx-target="#formauxiliaries" phx-click="period_chosen" <%= if @period_selected == item.id, do: 'selected' %> value="<%= item.id %> <%= item.start_date %> <%= item.end_date %>"><%= item.name %></option>
                  <% end %>
                </select>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                  <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                </div>
              </div>
            </div>
          </div>

          <div class="py-2">
            <button phx-click="search_auxiliaries" phx-target="#formauxiliaries" class="ml-mar-17 border tooltip w-10 h-hoch-2 bg-teal-500 rounded text-white hover:bg-teal-400 phx-target="#formauxiliaries">
              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="arrow-alt-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="h-6 w-6 ml-2">
                <path fill="currentColor" d="M0 304v-96c0-13.3 10.7-24 24-24h200V80.2c0-21.4 25.8-32.1 41-17L441 239c9.4 9.4 9.4 24.6 0 34L265 448.7c-15.1 15.1-41 4.4-41-17V328H24c-13.3 0-24-10.7-24-24z" class=""></path>
              </svg>
              <span class='tooltip-text text-white bg-blue-500 mt-5 -ml-10 rounded'>Buscar</span>
            </button>
          </div>



      </div>

      <%= if @list_auxiliaries != nil, do: live_component(@socket, AccountingSystemWeb.AuxiliariesComponent, id: "auxiliaries", list_auxiliaries: @list_auxiliaries) %>
      <%= if @list_auxiliaries != nil, do: live_component(@socket, AccountingSystemWeb.HeaderToAuxiliariesComponent, id: "headertoauxiliaries") %>
      <%= if @error, do: live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "error_comp", message: @error, show: true, notification_type: "error", change: "") %>
    """
  end

  def handle_event("account_from_chosen", params, socket) do
    account = String.split(params["value"])
    account_from_id_selected = Enum.at(account, 0) |> String.to_integer()
    account_from_selected = Enum.at(account, 1)

    {:noreply,
     assign(socket,
       account_from_selected: account_from_id_selected,
       account_from_selected_code: account_from_selected
     )}
  end

  def handle_event("account_to_chosen", params, socket) do
    account = String.split(params["value"])
    account_to_id_selected = Enum.at(account, 0) |> String.to_integer()
    account_to_selected = Enum.at(account, 1)

    {:noreply,
     assign(socket,
       account_to_selected: account_to_id_selected,
       account_to_selected_code: account_to_selected
     )}
  end

  def handle_event("start_date_chosen", params, socket) do
    {:noreply,
     assign(socket,
       start_date: params["start_date"],
       period_selected: 0
     )}
  end

  def handle_event("end_date_chosen", params, socket) do
    {:noreply,
     assign(socket,
       end_date: params["end_date"],
       period_selected: 0
     )}
  end

  def handle_event("period_chosen", params, socket) do
    period = String.split(params["value"])
    period_selected_id = Enum.at(period, 0) |> String.to_integer()
    start_date = if period_selected_id > 0, do: Enum.at(period, 1), else: ""
    end_date = if period_selected_id > 0, do: Enum.at(period, 2), else: ""

    {:noreply,
     assign(socket,
       period_selected: period_selected_id,
       start_date: start_date,
       end_date: end_date
     )}
  end

  def handle_event("search_auxiliaries", _params, socket) do
    start_date = socket.assigns.start_date
    end_date = socket.assigns.end_date
    account_from_code = socket.assigns.account_from_selected_code
    account_from_selected = socket.assigns.account_from_selected
    account_to_code = socket.assigns.account_to_selected_code
    account_to_selected = socket.assigns.account_to_selected
    period_selected = socket.assigns.period_selected

    if start_date != "" && end_date != "" && start_date < Date.to_string(Date.utc_today())  do
      start_date = Date.from_iso8601!(start_date)
      end_date = Date.from_iso8601!(end_date)

      if account_from_code != "" && account_to_code != "" do

        result = get_aux(start_date, end_date, account_from_code, account_to_code)
        result
        |> case do
          [] ->
            Notification.set_timer_notification_error()

            {:noreply,
             assign(socket,
               list_auxiliaries: nil,
               period_selected: 0,
               account_from_selected: 0,
               account_to_selected: 0,
               start_date: "",
               end_date: "",
               error: "No se encontraron datos con los parámetros ingresados"
             )}

          _ ->
            start_date = Date.to_string(start_date)
            end_date = Date.to_string(end_date)

            {:noreply,
             assign(socket,
               list_auxiliaries: result,
               period_selected: period_selected,
               account_from_selected: account_from_selected,
               account_to_selected: account_to_selected,
               start_date: start_date,
               end_date: end_date,
               error: nil
             )}
        end
      else
        result = get_aux(start_date, end_date)

        result
        |> case do
          [] ->
            Notification.set_timer_notification_error()

            {:noreply,
             assign(socket,
               list_auxiliaries: nil,
               period_selected: 0,
               account_from_selected: 0,
               account_to_selected: 0,
               start_date: "",
               end_date: "",
               error: "No se encontraron datos con los parámetros ingresados"
             )}

          _ ->
            start_date = Date.to_string(start_date)
            end_date = Date.to_string(end_date)

            {:noreply,
             assign(socket,
               list_auxiliaries: result,
               period_selected: period_selected,
               account_from_selected: account_from_selected,
               account_to_selected: account_to_selected,
               start_date: start_date,
               end_date: end_date,
               error: nil
             )}
        end
      end
    else
      Notification.set_timer_notification_error()

      {:noreply,
       assign(socket,
         list_auxiliaries: nil,
         period_selected: 0,
         account_from_selected: 0,
         account_from_selected_code: "",
         account_to_selected: 0,
         account_to_selected_code: "",
         start_date: "",
         end_date: "",
         error: "Parámetros de búsqueda incorrectos"
       )}
    end
  end

  def handle_event("close", _params, socket) do
    {:noreply,
     assign(socket,
       list_auxiliaries: nil,
       period_selected: 0,
       account_from_selected: 0,
       account_to_selected: 0,
       start_date: "",
       end_date: "",
       error: nil
     )}
  end

  defp get_aux(start_date, end_date, account_from_code, account_to_code) do
    start_date = if start_date.year < 2020, do: ~D[2020-01-01], else: start_date
    end_date =  if Date.to_string(end_date) > Date.to_string(Date.utc_today()), do: Date.utc_today(), else: end_date
    AccountingSystem.AuxiliaryHandler.get_aux_report(start_date, end_date, account_from_code, account_to_code)
  end

  defp get_aux(start_date, end_date) do
    start_date = if start_date.year < 2020, do: ~D[2020-01-01], else: start_date
    end_date =  if Date.to_string(end_date) > Date.to_string(Date.utc_today()), do: Date.utc_today(), else: end_date
    AccountingSystem.AuxiliaryHandler.get_aux_report(start_date, end_date)
  end

  defp get_periods(), do: Period.list_periods() |> Enum.sort_by(& &1.id)

  defp join_none_period(periods) do
    none = %AccountingSystem.PeriodSchema{
      id: 0,
      name: "Ninguno",
      start_date: nil,
      end_date: nil
    }

    List.flatten(periods, [none]) |> Enum.sort_by(& &1.id)
  end

  defp get_details_accounts(), do: Account.search_detail_account("")

  defp join_none_details_accounts(details_accounts) do
    none = %{
      key: ["", "Ninguna"],
      req_xml: false,
      value: 0
    }

    List.flatten(details_accounts, [none]) |> Enum.sort_by(& &1.value)
  end
end
