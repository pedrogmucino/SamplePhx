defmodule AccountingSystemWeb.QueryPeriodComponent do
  @moduledoc """
  Componente Query Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    #{:ok, socket}
    {:ok, assign(socket, list_periods: get_query_periods_test())}
  end

  def update(_attrs, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div id="queryperiodlist" class="bg-white h-hoch-93 w-80 mt-16 ml-16 block float-left">

        <div class="w-full py-2 bg-blue-700">
          <p class="ml-2 font-bold text-lg text-white">Periodos de Consulta</p>
        </div>

        <div class="relative w-full px-2 mt-4">
          <input class="focus:outline-none focus:bg-white focus:border-blue-500 h-8 w-full rounded border bg-gray-300 pl-2" placeholder="Buscar Periodos" >
          <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="absolute right-0 top-0 h-4 w-4 mr-4 mt-2">
            <g>
              <path fill="currentColor" d="M208 80a128 128 0 1 1-90.51 37.49A127.15 127.15 0 0 1 208 80m0-80C93.12 0 0 93.12 0 208s93.12 208 208 208 208-93.12 208-208S322.88 0 208 0z" class="text-gray-600"></path>
              <path fill="currentColor" d="M504.9 476.7L476.6 505a23.9 23.9 0 0 1-33.9 0L343 405.3a24 24 0 0 1-7-17V372l36-36h16.3a24 24 0 0 1 17 7l99.7 99.7a24.11 24.11 0 0 1-.1 34z" class="text-gray-500"></path>
            </g>
          </svg>
        </div>

        <div class="w-1/2 px-2 mt-2">
          <button phx-target="#queryperiodlist" class="py-2 bg-teal-500 hover:bg-teal-400 text-white items-center inline-flex font-bold rounded text-sm w-full">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="h-4 w-4 mr-2 ml-auto">
              <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z" class="text-white"></path>
            </svg>
            <label class="cursor-pointer mr-auto text-white">Nuevo</label>
          </button>
        </div>

        <div class="h-hoch-75 overflow-y-scroll pb-16 mt-2">
          <%= for item <- @list_periods do %>
            <div class="w-full px-2 block">
              <div phx-value-id="<%= item.id %>" phx-target="#queryperiodlist" class="border cursor-pointer w-full block bg-gray-200 p-3 mt-2 rounded relative hover:bg-gray-300">
                <h2 class="text-gray-700 text-xl"><%= item.name %></h2>
                <label class="inline-block cursor-pointer text-gray-600 font-bold text-sm">Inicio: <b><%= item.start_date %></b></label>
                <label class="ml-5 inline-block cursor-pointer text-gray-600 font-bold text-sm">Fin: <b><%= item.end_date %></b></label>
              </div>
            </div>
          <% end %>
        </div>

      </div
    """
  end

  defp get_query_periods_test(), do:
    [
      %{id: 1, name: "ENE-2020", start_date: "01/01/2020", end_date: "31/01/2020"},
      %{id: 2, name: "FEB-2020", start_date: "01/02/2020", end_date: "31/02/2020"},
      %{id: 3, name: "MAR-2020", start_date: "01/03/2020", end_date: "31/03/2020"},
      %{id: 4, name: "ABR-2020", start_date: "01/04/2020", end_date: "31/04/2020"},
      %{id: 5, name: "MAY-2020", start_date: "01/05/2020", end_date: "31/05/2020"}
    ]

end
