defmodule AccountingSystemWeb.SeriesListComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.{
    StructureHandler,
    SeriesHandler
  }

  def mount(socket) do
    {:ok, assign(socket,
    series_list: SeriesHandler.get_series,
    new?: false,
    edit?: false
    )}
  end

  def update(attrs, socket) do
      {:ok, assign(socket, id: attrs.id)}
  end

  def handle_event("create_series", params, socket) do
    params = Map.replace!(params, "number", Integer.to_string(Date.utc_today.year))
    case SeriesHandler.create_series(params) do
      {:ok, _series} ->
        {:noreply,
          socket
          |> put_flash(:info, "Serie creada")
          |> assign(series_list: SeriesHandler.get_series(), new?: false, edit?: false)
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("open_structure", params, socket) do
    assign(socket, structure: params["id"])
    id =
    params
    |> Map.get("id")

    {:noreply, assign(socket, new?: false, edit?: true, structure_id: id)}
  end

  def handle_event("set_size", params, socket) do
    try do
      structure =
      StructureHandler.get_structure!(params["structure_id"])
      attrs =
      %{"size" => params["size"]}

      case StructureHandler.update_code_size(structure, attrs) do
        {:error} ->
          socket
          |> put_flash(:error, "No puede tener un tamaño menor al tamaño máximo actual")
        _ ->
          StructureHandler.update_structure(structure, attrs)
          socket
          |> put_flash(:info, "Estructura actualizada")
      end
    rescue
      Ecto.NoResultsError ->
        socket
        |> put_flash(:info, "Estructura eliminada")
    end

    {:noreply, assign(socket, list_configuration: StructureHandler.list_structures(), new?: false, edit?: false)}
  end

  def handle_event("delete_structure", params, socket) do
    last_structure =
    StructureHandler.get_last_structure

    params["id"]
    |> execute_delete(last_structure.id == String.to_integer(params["id"]), socket)

    {:noreply, assign(socket, list_configuration: StructureHandler.list_structures(), edit?: false)}
  end

  def handle_event("create_new", _params, socket) do
    {:noreply, assign(socket, new?: true, edit?: false)}
  end

  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, new?: false, edit?: false)}
  end

  defp execute_delete(id, true, socket) do
    id
    |> StructureHandler.get_structure!
    |> StructureHandler.delete_structure
    socket
    |> put_flash(:info, "Estructura eliminada")
  end

  defp execute_delete(_id, false, socket) do
    socket
    |> put_flash(:info, "No es posible eliminar estructura")
  end



  def render(assigns) do
    ~L"""

    <div id="one" class="bg-white h-hoch-93 w-80 mt-16 ml-16 block float-left">
    <div class="relative w-full px-2 mt-4">
      <input class="focus:outline-none focus:bg-white focus:border-blue-500 h-8 w-full rounded border bg-gray-300 pl-2" placeholder="Buscar Serie" >
      <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
        class="absolute right-0 top-0 h-4 w-4 mr-4 mt-2">
        <g>
          <path fill="currentColor" d="M208 80a128 128 0 1 1-90.51 37.49A127.15 127.15 0 0 1 208 80m0-80C93.12 0 0 93.12 0 208s93.12 208 208 208 208-93.12 208-208S322.88 0 208 0z"
          class="text-gray-600">
          </path>
          <path fill="currentColor" d="M504.9 476.7L476.6 505a23.9 23.9 0 0 1-33.9 0L343 405.3a24 24 0 0 1-7-17V372l36-36h16.3a24 24 0 0 1 17 7l99.7 99.7a24.11 24.11 0 0 1-.1 34z"
          class="text-gray-500">
          </path>
        </g>
      </svg>
    </div>

    <div class="w-1/2 px-2 mt-2">
      <button phx-click="create_new" phx-value-id="xxx" phx-target="#one" class="py-2 bg-teal-500 hover:bg-teal-400 text-white items-center inline-flex font-bold rounded text-sm w-full ">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
        class="h-4 w-4 mr-2 ml-auto">
          <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"
          class="text-white">
          </path>
        </svg>
        <label class="cursor-pointer mr-auto text-white">Nueva</label>
      </button>
    </div>

    <div class="h-hoch-80 overflow-y-scroll pb-16">
      <%= for item <- @series_list do %>
        <div class="w-full px-2 block">
          <div phx-click="open_structure" phx-value-id="<%= item.id %>" phx-target="#one" class="border cursor-pointer w-full block bg-gray-200 p-3 mt-2 rounded relative hover:bg-gray-300">
            <h2 class="text-gray-700 text-xl">Serie: <%= item.serial  %>-<%= item.number %></h2>
            <label class="inline-block cursor-pointer text-gray-600 font-bold text-sm">Folio Actual: <b><%= item.current_number %></b></label>
            <label class="ml-10 inline-block cursor-pointer text-gray-600 font-bold text-sm">Tipo: <b><%= item.name %></b></label>
          </div>
        </div>

      <% end %>
    </div>
    </div>

    <%= if @new? do %>
      <%= live_component(@socket, AccountingSystemWeb.SeriesComponent, id: "series") %>
    <% end %>

    <%= if @edit? do %>

      <%= live_component(@socket, AccountingSystemWeb.ConfigurationEditComponent, id: @structure_id) %>
    <% end %>
    """
  end
end
