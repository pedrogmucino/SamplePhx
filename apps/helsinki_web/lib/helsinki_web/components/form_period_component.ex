defmodule AccountingSystemWeb.FormPeriodComponent do
  @moduledoc """
  Componente Form Period Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, assign(socket, new?: false, edit?: false)}
  end

  def update(attrs, socket) do
    {:ok, assign(socket, new?: attrs.new?, edit?: attrs.edit?)}
  end

  def render(assigns) do
    ~L"""
      <div id="formquery" class="bg-white mt-16 ml-1 w-80 h-hoch-93 rounded border float-left">
        <div class="inline-block bg-blue-700 text-white px-6 py-4 w-full">
          <div class="inline-flex top-0 right-0 bg-blue-700 text-white mt-2">
            <button phx-click="close" phx-target="#formquery" class="ml-mar-16.5 -mt-4 text-white font-bold rounded shadow">
              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="h-5 w-5 ml-auto">
                <path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z" class=""></path>
              </svg>
            </button>
          </div>
          <h1 class="text-2xl font-medium text-white block"> <%= if @new?, do: "Crear Periodo de Consulta", else: "Editar Periodo de Consulta" %></h1>
        </div>

        <div class="h-hoch-80 px-8 w-full py-6 inline-flex -mt-8 relative">
          <form phx-submit= <%= if @new?, do: "save_new_period", else: "save_edit_period" %> phx-target="#formquery">
            <label class="block tracking-wide text-gray-700 font-bold">Nombre</label>
            <input type="text" name="name" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Introduce el Nombre">
            <label class="block tracking-wide text-gray-700 font-bold">Fecha Inicial</label>
            <input type="date" name="start_date" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Introduce el Nombre">
            <label class="block tracking-wide text-gray-700 font-bold">Fecha Final</label>
            <input type="date" name="end_date" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Introduce el Nombre">
            <div class="inline-flex w-full py-16 absolute bottom-0 right-0 pr-0">
            <button class= "ml-5 py-2 w-32 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
              <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="save" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="h-4 w-4 mr-2 ml-auto">
                <g class="fa-group">
                  <path fill="currentColor" d="M288 352a64 64 0 1 1-64-64 64 64 0 0 1 64 64z" class="text-white"></path>
                  <path fill="currentColor" d="M433.94 129.94l-83.88-83.88A48 48 0 0 0 316.12 32H48A48 48 0 0 0 0 80v352a48 48 0 0 0 48 48h352a48 48 0 0 0 48-48V163.88a48 48 0 0 0-14.06-33.94zM224 416a64 64 0 1 1 64-64 64 64 0 0 1-64 64zm96-204a12 12 0 0 1-12 12H76a12 12 0 0 1-12-12V108a12 12 0 0 1 12-12h228.52a12 12 0 0 1 8.48 3.52l3.48 3.48a12 12 0 0 1 3.52 8.48z" class="text-white"></path>
                </g>
              </svg>
              <label class="cursor-pointer mr-auto text-white">Guardar</label>
            </button>
          </div>
          </form>
        </div>

      </div>

    """
  end

end
