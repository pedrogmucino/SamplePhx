defmodule AccountingSystemWeb.BalanceListComponent do
  @moduledoc """
  Componente Form Auxiliaries Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, assign(socket, balance: nil)}
  end

  def update(attrs, socket) do
    {:ok, assign(socket, balance: attrs.balance)}
  end

  def render(assigns) do
    ~L"""
        <div id="balance_list" class="mt-16 w-full bg-white h-hoch-93 overflow-y-scroll">

          <div class="inline-block bg-blue-700 text-white px-6 py-4 w-full">
          <b>Balanza</b>
            <button phx-target="#balance" class="ml-mar-360 -mr-2 -mt-4 text-white font-bold rounded shadow">
              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="h-5 w-5 ml-auto">
                <path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z" class=""></path>
              </svg>
            </button>
          </div>

        <div class="m-4 mr-4 mt-4 mb-4 border-t-2 border-gray-300"></div>
          <table class="table-auto">
            <thead>
              <tr>
                <th class="w-56 px-4 py-2">Cuenta</th>
                <th class="w-32 px-4 py-2">Nombre</th>
                <th class="w-32 px-4 py-2">Tipo Cuenta</th>
                <th class="w-80 px-4 py-2">Saldo Inicial</th>
                <th class="w-40 px-4 py-2">Cargo</th>
                <th class="w-40 px-4 py-2">Abono</th>
                <th class="w-80 px-4 py-2">Saldo FInal</th>
              </tr>
              </thead>
              <tbody class="bg-gray-200">
                <%= for acc <- @balance do %>
                <tr>
                  <th class="w-56 px-4 py-2"><%= acc.account %></th>
                  <th class="w-32 px-4 py-2"><%= acc.description %></th>
                  <th class="w-32 px-4 py-2"><%= acc.type %></th>
                  <th class="w-80 px-4 py-2">0.0</th>
                  <th class="w-40 px-4 py-2"><%= acc.credit %></th>
                  <th class="w-40 px-4 py-2"><%= acc.debit %></th>
                  <th class="w-80 px-4 py-2">0.0</th>
                </tr>
                <% end %>
              </tbody>
              <tbody>
                <tr>
                  <th class="w-56 px-4 py-2">Cuentas Reportadas</th>
                  <th class="w-32 px-4 py-2"><%= Enum.count(@balance) %></th>
                  <th class="w-32 px-4 py-2"></th>
                  <th class="w-80 px-4 py-2">0.0</th>
                  <th class="w-40 px-4 py-2"><%= Float.round(
                                                Enum.filter(@balance, fn acc -> acc.parent_account == -1 end)
                                                  |> Enum.map(fn acc -> acc.credit end)
                                                  |> Enum.sum(), 2)
                                              %></th>
                  <th class="w-40 px-4 py-2"><%= Float.round(
                                                  Enum.filter(@balance, fn acc -> acc.parent_account == -1 end)
                                                    |> Enum.map(fn acc -> acc.debit end)
                                                    |> Enum.sum(), 2)
                                              %></th>
                  <th class="w-80 px-4 py-2"> <%= Float.round((Enum.filter(@balance, fn acc -> acc.parent_account == -1 end) |> Enum.map(fn acc -> acc.credit end) |> Enum.sum()) - (Enum.filter(@balance, fn acc -> acc.parent_account == -1 end) |> Enum.map(fn acc -> acc.debit end) |> Enum.sum()), 2) %>
                  </th>
                </tr>
              </tbody>
          </table>
        </div>
      </div>

      """
  end
end
