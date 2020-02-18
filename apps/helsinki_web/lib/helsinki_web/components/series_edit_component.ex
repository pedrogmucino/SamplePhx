
defmodule AccountingSystemWeb.SeriesEditComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.{
    SeriesHandler
  }

  def mount(socket) do
    {:ok, socket}
  end
  def render(assigns) do
    ~L"""
    <div id="series_comp" class="bg-white mt-16 ml-1 w-80 h-hoch-93 rounded border">


      <div class="inline-block bg-blue-700 text-white px-6 py-4 w-full">
        <div class="inline-flex top-0 right-0 bg-blue-700 text-white mt-2">
          <button phx-click="close" phx-target="#series_comp" class="ml-mar-16.5 -mt-4 text-white font-bold rounded shadow">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
            class="h-5 w-5 ml-auto">
              <path fill="currentColor"
                d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z"
                class="">
              </path>
            </svg>
          </button>
        </div>
        <h1 class="text-2xl font-medium text-white block">Editar serie de póliza</h1>


        <div class="mt-2">
          <label class="block">Tipo: <b><%= @series.type%></b></label>
          <label class="block">Actual: <b><%= @series.current_number %></b></label>
        </div>

      </div>


      <div class="h-hoch-80 px-8 w-full py-6 inline-flex -mt-8 relative" >
        <form phx-submit="set_series" phx-target="#series_comp">
          <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Serie</label>
          <label class="cursor-pointer mr-auto text-white"></label>
          <input type="text" name="serial" value=<%= @series.serial %> class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Introduce la serie deseada">
          <input type="hidden" name="number" value=<%= @series.number %>>
          <input type="hidden" name="series_id" value=<%= @series.id %>>
          <div class="inline-flex w-full py-16 absolute bottom-0 right-0 pr-0">
            <button phx-click="delete_structure" phx-target="#comp" phx-value-id=<%= @series.id %> class= "ml-auto mr-6 w-24 py-2 bg-red-800 text-yellow-200 text-center font-bold rounded shadow hover:bg-red-500 focus:shadow-outline focus:outline-none rounded">
              Eliminar
            </button>
            <button class= "ml-auto mr-6 w-24 py-2 bg-teal-500 text-teal-100 text-center font-bold rounded shadow hover:bg-teal-400 focus:shadow-outline focus:outline-none rounded">
              Actualizar
            </button>
          </div>
        </form>
      </div>
    </div>
    """
  end
  def update(params, socket) do
    series =
    Map.get(params, :id)
    |> get_series

    {:ok, assign(socket, series: series)}
  end

  def get_series(id) do
    SeriesHandler.get_serie(id)
  end
end
