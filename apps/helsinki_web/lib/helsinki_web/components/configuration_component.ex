defmodule AccountingSystemWeb.ConfigurationComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.{
    StructureHandler,
    StructureSchema
  }

  def mount(socket) do
    {:ok, assign(socket,
    structure: get_structure()) }
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
        <h1 class="text-2xl font-medium text-white block">Account Configuration</h1>
        <div class="mt-2">
          <label class="block">Nivel: <b><%= @structure.level + 1 %></b></label>
          <label class="block">Tamaño máximo actual: <b>0</b></label>
        </div>
      </div>

      <div class="h-hoch-80 px-8 w-full py-6 inline-flex -mt-8 relative" >
        <form phx-submit="create_structure" phx-target="#comp">
          <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Tamaño</label>
          <label class="cursor-pointer mr-auto text-white"></label>
          <input type="number" name="size" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Introduce el tamaño deseado">
          <input type="hidden" name="level" value=<%= @structure.level + 1 %>>
          <input type="hidden" name="max_current_size" value=0>
          <div class="inline-flex w-full py-3 absolute bottom-0 right-0 pr-0">
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
