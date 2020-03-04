defmodule AccountingSystemWeb.ConfirmationComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML


  def mount(socket) do
    {:ok, assign(socket, show: true, message: nil) }
  end

  def render(assigns) do
    ~L"""
    <%= if @show do %>
    <div id="x" class="fixed w-full flex bottom-0 left-0">
      <div class="top-12 py-16 ml-auto mr-auto " role="alert" >
        <div class="w-160 bg-yellow-100 border-t-4 border-yellow-500 rounded-b text-yellow-900 px-4 py-3 shadow-md" role="alert">
          <div class="flex">
            <div class="py-1"><svg class="fill-current h-6 w-6 text-yellow-500 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z"/></svg></div>
            <div>
              <p class="font-bold">Advertencia</p>
              <p class="text-sm w-80"><%= @message %></p>
            </div>
            <div class="inline-flex py-4">
              <button phx-click="si_" phx-target="#x" class="ml-20 h-10 px-2 w-24 bg-yellow-500 hover:bg-yellow-400 text-yellow-900 font-bold py-2 px-4 border border-yellow-900 rounded">
                Sí
              </button>
              <button phx-click="no_" phx-target="#x" class="ml-8 inline-flex items-center rounded-full h-8 w-8 mt-1 -mr-2 hover:bg-yellow-400">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 512"
                class="h-6 w-6 ml-auto mr-auto text-yellow-900">
                  <path fill="currentColor" d="M242.72 256l100.07-100.07c12.28-12.28 12.28-32.19 0-44.48l-22.24-22.24c-12.28-12.28-32.19-12.28-44.48 0L176 189.28 75.93 89.21c-12.28-12.28-32.19-12.28-44.48 0L9.21 111.45c-12.28 12.28-12.28 32.19 0 44.48L109.28 256 9.21 356.07c-12.28 12.28-12.28 32.19 0 44.48l22.24 22.24c12.28 12.28 32.2 12.28 44.48 0L176 322.72l100.07 100.07c12.28 12.28 32.2 12.28 44.48 0l22.24-22.24c12.28-12.28 12.28-32.19 0-44.48L242.72 256z" class="">
                  </path>
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <% end %>
    """
  end

  def update(attrs, socket) do
    attrs |> IO.inspect(label: " --> --> Params confirmation -> ")
    {:ok, assign(socket, message: Map.get(attrs, :message), show: Map.get(attrs, :show))}
  end
end
