defmodule AccountingSystemWeb.SeriesComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.{
    PolicyTipeHandler,
    StructureHandler,
    StructureSchema
  }

  def mount(socket) do
    policytypes = AccountingSystem.PolicyTipeHandler.get_types
    {:ok, assign(socket, policy_types: policytypes) }
  end

  def get_structure() do
    try do
      StructureHandler.get_last_structure
    rescue
      Ecto.NoResultsError ->
        %StructureSchema{level: -1, size: 0, max_current_size: 0}
    end
  end


  def render(assigns) do
    ~L"""
    <div id="comp" class="bg-white mt-16 ml-1 w-80 h-hoch-93 rounded border">

      <div class="inline-block bg-blue-700 text-white px-6 py-4 w-full">
      <div class="inline-flex top-0 right-0 bg-blue-700 text-white mt-2">
          <button phx-click="close" phx-target="#comp" class="ml-mar-16.5 -mt-4 text-white font-bold rounded shadow">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
            class="h-5 w-5 ml-auto">
              <path fill="currentColor"
                d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z"
                class="">
              </path>
            </svg>
          </button>
        </div>
        <h1 class="text-2xl font-medium text-white block">Crear serie de póliza</h1>
        <div class="mt-2">
          <label class="block">Nueva serie</b></label>
        </div>
      </div>

      <div class="h-hoch-80 px-8 w-full py-6 inline-flex -mt-8 relative" >
        <form phx-submit="create_serie" phx-target="#comp" id="series_form">
          <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Serie</label>
          <label class="cursor-pointer mr-auto text-white"></label>
          <input type="text" name="serial" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Introduce la serie">

          <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Tipo de póliza</label>
          <label class="cursor-pointer mr-auto text-white"></label>
          <select id="types" name="type_list" form="series_form">
            <%= for item <- @policy_types do %>
              <option value=<%= item.value %>><%= item.key %></option>
            <% end %>
          </select>
          <input type="hidden" name="number" value=0>
          <input type="hidden" name="current_number" value=0>
          <div class="inline-flex w-full py-16 absolute bottom-0 right-0 pr-0">
            <button class= "ml-auto mr-6 w-24 py-2 bg-teal-500 text-teal-100 text-center font-bold rounded shadow hover:bg-teal-400 focus:shadow-outline focus:outline-none rounded">
              Guardar
            </button>
          </div>
        </form>
      </div>
    </div>
    """

  end

  def update(_assigns, socket) do
    {:ok, assign(socket,
    structure: get_structure()) }
  end

end
