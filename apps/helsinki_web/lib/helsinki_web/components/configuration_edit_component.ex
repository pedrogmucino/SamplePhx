
defmodule AccountingSystemWeb.ConfigurationEditComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.{
    StructureHandler
  }

  def mount(socket) do
    {:ok, socket}
  end
  def render(assigns) do
    ~L"""
    <div id="comp" class="bg-white mt-16 ml-1 w-80 h-hoch-93 rounded border">

      <div class="inline-block bg-blue-700 text-white px-6 py-4 w-full">
        <h1 class="text-2xl font-medium text-white block">Account Configuration</h1>
        <div class="mt-2">
          <label class="block">Nivel: <b><%= @structure.level%></b></label>
          <label class="block">Tamaño máximo actual: <b><%= @structure.max_current_size %></b></label>
        </div>
      </div>

      <div class="h-hoch-80 px-8 w-full py-6 inline-flex -mt-8 relative" >
        <form phx-submit="set_size" phx-target="#comp">
          <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Tamaño</label>
          <label class="cursor-pointer mr-auto text-white"></label>
          <input type="number" name="size" min="1" value=<%= @structure.size %> class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Introduce el tamaño deseado">
          <input type="hidden" name="level" value=<%= @structure.level %>>
          <input type="hidden" name="max_current_size" value= <%= @structure.max_current_size %> >
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
  def update(params, socket) do
    structure =
    Map.get(params, :id)
    |> IO.inspect(label: "structure_id")
    |> get_structure

    {:ok, assign(socket, structure: structure)}
  end

  def get_structure(id) do
    StructureHandler.get_structure!(id)
  end




end
