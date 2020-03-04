defmodule AccountingSystemWeb.SubAccountsComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AccountingSystem.StructureHandler

  def mount(socket) do
    {:ok, socket}
  end

  def update(attrs, socket) do
    max_level = StructureHandler.get_max_level()
    {:ok, assign(socket,
      level: attrs.next_level,
      id: attrs.id,
      name: attrs.father_name,
      subaccounts: attrs.subaccounts,
      code: attrs.code,
      type: attrs.type,
      description: attrs.description,
      status_father: (if max_level >= attrs.next_level and attrs.status_father == "A" and attrs.type == "A", do: true, else: false),
      error: nil,
      change: false)
    }
  end

  def error_message(message, socket) do
    Task.async(fn ->
      :timer.sleep(5500)

      assign(socket, error: nil)
      %{error: "close"}
    end)
    {:noreply, assign(socket, error: message, change: !socket.assigns.change)}
  end

  def render(assigns) do
    ~L"""
    <div class="z-40">
    <%= if @error do %>
        <%=live_component(@socket, AccountingSystemWeb.ErrorComponent, id: "error_comp", error: @error, show: true, change: @change) %>
    <% end %>
    </div>
    <div id="sub_account-<%= @id %>" phx-hook="scroll_x" class="bg-white h-hoch-90 w-80 float-left ml-1 mt-16 block">
      <div class=" w-full pt-6 bg-gray-200">
        <div class="block text-white px-3 text-center">
          <h1 class="tooltip text-2xl font-medium text-gray-800"> <%= if String.length(@name) > 32, do: String.slice(@name, 0, 32) <> "...", else: @name %>
            <%= if String.length(@name) > 32 do %>
              <span class='tooltip-text text-sm text-white bg-blue-500 mt-8 -ml-24 mr-1 rounded'><%= @name %></span>
            <% end %>
          </h1>
          <label class="tooltip block text-gray-700 text-sm font-bold"><b><%= String.slice(@code, 0, 70) %></b>
            <%= if String.length(@code) > 70 do %>
              <span class='tooltip-text text-sm text-white bg-blue-500 mt-8 -ml-56 rounded'><%= @code %></span>
            <% end %>
          </label>
          <br>
          <label class="block text-gray-700"><b><%= @description %></b></label>
          <label class="block text-gray-700"><b><%= if @type == "A", do: "Acumulativo", else: "Detalle" %></b></label>
          <div class="w-full inline-flex py-2">

            <div class="w-1/2 px-2">
              <%= if @status_father do %>
              <button phx-click="create_new" phx-value-id="<%= @id %>" phx-value-level="<%= @level %>" phx-target="#one" class="py-2 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded text-sm w-full ">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
                  class="h-4 w-4 mr-2 ml-auto">
                  <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"
                  class="text-white">
                  </path>
                </svg>
                <label class="cursor-pointer mr-auto text-white">Nueva</label>
              </button>
              <% end %>
            </div>

            <div class="w-1/2 px-2">
              <button phx-click="edit_this" phx-value-id="<%= @id %>" phx-value-level="<%= @level %>" phx-value-code="<%= @code %>" phx-target="#one" class="py-2 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded text-sm w-full ">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="pencil-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
                  class="h-4 w-4 mr-2 ml-auto">
                  <path fill="currentColor" d="M497.9 142.1l-46.1 46.1c-4.7 4.7-12.3 4.7-17 0l-111-111c-4.7-4.7-4.7-12.3 0-17l46.1-46.1c18.7-18.7 49.1-18.7 67.9 0l60.1 60.1c18.8 18.7 18.8 49.1 0 67.9zM284.2 99.8L21.6 362.4.4 483.9c-2.9 16.4 11.4 30.6 27.8 27.8l121.5-21.3 262.6-262.6c4.7-4.7 4.7-12.3 0-17l-111-111c-4.8-4.7-12.4-4.7-17.1 0zM124.1 339.9c-5.5-5.5-5.5-14.3 0-19.8l154-154c5.5-5.5 14.3-5.5 19.8 0s5.5 14.3 0 19.8l-154 154c-5.5 5.5-14.3 5.5-19.8 0zM88 424h48v36.3l-64.5 11.3-31.1-31.1L51.7 376H88v48z"
                  class="text-white">
                  </path>
                </svg>
                <label class="cursor-pointer mr-auto text-white">Editar</label>
              </button>
            </div>
          </div>
        </div>
      </div>

      <%= for item <- @subaccounts do %>
        <div class="w-full p-2 block cursor-pointer" phx-click="open_child" phx-value-origin="false" phx-value-level="<%= @level %>" phx-value-id="<%= item.id %>" phx-target="#one">
          <div class="hover:bg-gray-300 border w-full block bg-gray-200 p-3 rounded relative">
            <h2 class="tooltip pt-4 text-gray-800 text-xl"> <%= if String.length(item.name) > 38, do: String.slice(item.name, 0, 38) <> "...", else: item.name %>
              <%= if String.length(item.name) > 38 do %>
                <span class='tooltip-text text-sm text-white bg-blue-500 mt-8 -ml-24 mr-1 rounded'><%= item.name %></span>
              <% end %>
            </h2>
            <label class="tooltip cursor-pointer text-gray-600 font-bold text-sm"> Código: <b><%= String.slice(item.code,0 ,70) %></b>
              <%= if String.length(item.code) > 70 do %>
                <span class='tooltip-text text-sm text-white bg-blue-500 mt-8 -ml-56 rounded'><%= item.code %></span>
              <% end %>
            </label>
            <br>
            <label class="cursor-pointer text-gray-600 font-bold text-sm"> Tipo: <b><%= if item.type == "A", do: "Acumulativo", else: "Detalle" %></b></label>
            <div class="absolute bg-<%= if item.status == "A", do: "green", else: "red" %>-200 px-3 text-sm font-bold top-0 right-0 rounded-full text-<%= if item.status == "A", do: "green", else: "red" %>-700 mt-2 mr-2">
            <%= if item.status == "A", do: "Activo", else: "Inactivo" %>
            </div>
          </div>
        </div>
      <% end %>
    </div>

    """
  end

  @spec handle_event(<<_::96>>, nil | keyword | map, Phoenix.LiveView.Socket.t()) ::
          {:noreply, any}
  def handle_event("select_child", params, socket) do
    {:noreply, assign(socket, child?: true, child_id: params["name"] )}
  end

end
