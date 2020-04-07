defmodule AccountingSystemWeb.AuxiliariesComponent do
  @moduledoc """
  Componente Form Auxiliaries Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, assign(socket, list_auxiliaries: [])}
  end

  def update(attrs, socket) do
    {:ok, assign(socket, list_auxiliaries: attrs.list_auxiliaries)}
  end

  def render(assigns) do
    ~L"""
      <div id="auxiliaries_list" class="mt-16 w-full bg-white h-hoch-93 overflow-y-scroll">

        <div class="inline-block bg-blue-700 text-white px-6 py-4 w-full">
          <button phx-click="close" phx-target="#auxiliaries_list" class="ml-mar-360 -mr-2 -mt-4 text-white font-bold rounded shadow">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="h-5 w-5 ml-auto">
              <path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z" class=""></path>
            </svg>
          </button>
        </div>

      <div class="m-4 mr-4 mt-4 mb-4 border-t-2 border-gray-300"></div>
        <table class="table-auto">
          <thead>
            <tr>
              <th class="w-56 px-4 py-2">Tipo Póliza</th>
              <th class="w-32 px-4 py-2">Número Póliza</th>
              <th class="w-32 px-4 py-2">Fecha</th>
              <th class="w-80 px-4 py-2">Cuenta Detalle</th>
              <th class="w-40 px-4 py-2">Caja</th>
              <th class="w-40 px-4 py-2">Abono</th>
              <th class="w-80 px-4 py-2">Concepto</th>
            </tr>
          </thead>
        </table>
        <div class="ml-4 mr-4 mb-4 border-solid border-2 border-gray-300 p-4 rounded">
          <%= for item <- @list_auxiliaries do %>
            <div class="py-1">
              <label><b><%= item.name %></b></label>
              <div class="bg-gray-300 border rounded relative">
                <%= for item2 <- item.details do %>
                  <div>
                    <div class="inline-flex w-48 px-2 py-2"><%= item2.policy_type %></div>
                    <div class="inline-flex w-32 px-2 py-2"><%= item2.number %></div>
                    <div class="inline-flex w-32 px-2 py-2"><%= item2.date %></div>
                    <div class="inline-flex w-80 px-2 py-2"><%= item.code %></div>
                    <div class="inline-flex w-40 px-2 py-2 justify-end" phx-hook="format_number"><%= if item2.auxiliary_type == "D", do: item2.amount %></div>
                    <div class="inline-flex w-40 px-2 py-2 justify-end" phx-hook="format_number"><%= if item2.auxiliary_type == "H", do: item2.amount %></div>
                    <div class="inline-flex w-80 px-2 py-2"><%= item2.concept %></div>
                  </div>
                <% end %>
                <div>
                  <div class="inline-flex w-200 px-4 py-2"></div>
                  <div class="inline-flex w-40 px-4 py-2 justify-end ml-5 font-semibold" phx-hook="format_number"><%= item.debe %></div>
                  <div class="inline-flex w-40 px-4 py-2 justify-end font-semibold" phx-hook="format_number"><%= item.haber %></div>
                </div>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    """
  end

end
