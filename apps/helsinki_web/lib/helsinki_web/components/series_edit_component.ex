
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
          <input type="hidden" name="fiscal_exercise" value=<%= @series.fiscal_exercise %>>
          <input type="hidden" name="series_id" value=<%= @series.id %>>
          <div class="inline-flex w-full py-16 absolute bottom-0 right-0 pr-0">
            <button class= "ml-5 py-2 w-32 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
              <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="save" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
                class="h-4 w-4 mr-2 ml-auto">
                <g class="fa-group">
                  <path fill="currentColor" d="M288 352a64 64 0 1 1-64-64 64 64 0 0 1 64 64z"
                  class="text-white">
                  </path>
                  <path fill="currentColor" d="M433.94 129.94l-83.88-83.88A48 48 0 0 0 316.12 32H48A48 48 0 0 0 0 80v352a48 48 0 0 0 48 48h352a48 48 0 0 0 48-48V163.88a48 48 0 0 0-14.06-33.94zM224 416a64 64 0 1 1 64-64 64 64 0 0 1-64 64zm96-204a12 12 0 0 1-12 12H76a12 12 0 0 1-12-12V108a12 12 0 0 1 12-12h228.52a12 12 0 0 1 8.48 3.52l3.48 3.48a12 12 0 0 1 3.52 8.48z"
                  class="text-white">
                  </path>
                </g>
              </svg>
              <label class="cursor-pointer mr-auto text-white">Guardar</label>
            </button>
        </form>
      </div>

      <div class="inline-flex w-1/2 h-10 mb-16 absolute bottom-0 right-0 pr-0">
        <button <%= if @editable, do: 'disabled' %> phx-click="delete_series" phx-target="#one" phx-value-id=<%= @series.id %>
          class= "<%= if @editable, do: 'opacity-50 cursor-not-allowed' %> ml-2 py-2 w-32 bg-red-500 text-white hover:bg-red-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
            <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="trash-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
              class="h-4 w-4 mr-2 ml-auto">
              <g class="fa-group">
                <path fill="currentColor" d="M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V96H32zm272-288a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0z"
                  class="fa-secondary">
                </path>
                <path fill="currentColor" d="M432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16zM128 160a16 16 0 0 0-16 16v224a16 16 0 0 0 32 0V176a16 16 0 0 0-16-16zm96 0a16 16 0 0 0-16 16v224a16 16 0 0 0 32 0V176a16 16 0 0 0-16-16zm96 0a16 16 0 0 0-16 16v224a16 16 0 0 0 32 0V176a16 16 0 0 0-16-16z"
                  class="fa-primary">
                </path>
              </g>
            </svg>
            <label class="<%= if @editable, do: 'cursor-not-allowed', else: 'cursor-pointer' %> mr-auto text-white">Eliminar</label>
        </button>
        </div>
      </div>
    </div>
    """
  end
  def update(params, socket) do
    series =
    Map.get(params, :id)
    |> get_series
    {:ok, assign(socket, series: series, editable: (series.current_number > 0))}
  end

  def get_series(id) do
    SeriesHandler.get_serie(id)
  end
end
