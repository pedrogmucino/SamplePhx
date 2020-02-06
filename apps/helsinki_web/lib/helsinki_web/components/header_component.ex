defmodule AccountingSystemWeb.HeaderComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
    <div class="fixed w-full py-2 bg-blue-900 top-0 left-0 z-20">
      <div class="flex">
        <img src="https://santiago.mx/assets/images/logo-white.png" class="w-56 ml-6">

        <div class="ml-auto block text-right">
          <p class="font-bold text-lg text-white ">Héctor López</p>
          <p class="text-medium text-white ">Administrador contable</p>
        </div>
        <div class="inline-flex items-center ml-4 mr-6">
          <img src="https://cdn.memegenerator.es/imagenes/memes/full/26/81/26810815.jpg" class="rounded-full w-10 h-10">
        </div>
      </div>
    </div>

    <div class="fixed top-0 left-0 h-screen px-2 bg-white block z-10 shadow-lg transition-menu w-16">
        <div class="block h-24"></div>
        <%= for item <- @menu do %>
          <div class="block my-3">
            <a href="<%= item.link %>" class="rounded hover:border-gray-200 text-blue-500 hover:bg-gray-200 py-1 inline-flex items-center w-full">
              <%= Phoenix.HTML.raw(item.icon ) %>
              <label class="cursor-pointer ml-2 mr-auto font-bold transition-menu-label"><%= item.name %></label>
            </a>
          </div>
        <% end %>


      <div class="absolute inset-x-0 bottom-0 h-12">

        <a href="/configuration" class="rounded hover:border-gray-200 text-blue-500 hover:bg-gray-200 py-1 inline-flex items-center w-full">
        <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="cog" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
          class="h-8 w-8 ml-2 mr-auto">
            <g>
              <path fill="currentColor" d="M487.75 315.6l-42.6-24.6a192.62 192.62 0 0 0 0-70.2l42.6-24.6a12.11 12.11 0 0 0 5.5-14 249.2 249.2 0 0 0-54.7-94.6 12 12 0 0 0-14.8-2.3l-42.6 24.6a188.83 188.83 0 0 0-60.8-35.1V25.7A12 12 0 0 0 311 14a251.43 251.43 0 0 0-109.2 0 12 12 0 0 0-9.4 11.7v49.2a194.59 194.59 0 0 0-60.8 35.1L89.05 85.4a11.88 11.88 0 0 0-14.8 2.3 247.66 247.66 0 0 0-54.7 94.6 12 12 0 0 0 5.5 14l42.6 24.6a192.62 192.62 0 0 0 0 70.2l-42.6 24.6a12.08 12.08 0 0 0-5.5 14 249 249 0 0 0 54.7 94.6 12 12 0 0 0 14.8 2.3l42.6-24.6a188.54 188.54 0 0 0 60.8 35.1v49.2a12 12 0 0 0 9.4 11.7 251.43 251.43 0 0 0 109.2 0 12 12 0 0 0 9.4-11.7v-49.2a194.7 194.7 0 0 0 60.8-35.1l42.6 24.6a11.89 11.89 0 0 0 14.8-2.3 247.52 247.52 0 0 0 54.7-94.6 12.36 12.36 0 0 0-5.6-14.1zm-231.4 36.2a95.9 95.9 0 1 1 95.9-95.9 95.89 95.89 0 0 1-95.9 95.9z"
                class="text-blue-500">
              </path>
              <path fill="currentColor" d="M256.35 319.8a63.9 63.9 0 1 1 63.9-63.9 63.9 63.9 0 0 1-63.9 63.9z"
                class="text-blue-900">
              </path>
            </g>
        </svg>
          <label class="cursor-pointer ml-2 mr-auto font-bold transition-menu-label">Configuration</label>
        </a>
      </div>

    </div>
    """
  end
  def mount(socket) do
    {:ok, assign(socket, menu: get_menu())}
  end

  def update(_attrs, socket) do
      {:ok, socket}
  end

  defp get_menu(), do:
  [
    %{name: "Inicio", link: "/home", icon: """
      <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="home" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"
      class="h-8 w-8 ml-2 mr-auto">
        <g>
          <path fill="currentColor" d="M336 463.59V368a16 16 0 0 0-16-16h-64a16 16 0 0 0-16 16v95.71a16 16 0 0 1-15.92 16L112 480a16 16 0 0 1-16-16V300.06l184.39-151.85a12.19 12.19 0 0 1 15.3 0L480 300v164a16 16 0 0 1-16 16l-112-.31a16 16 0 0 1-16-16.1z"
          class="text-blue-500">
          </path>
          <path fill="currentColor" d="M573.32 268.35l-25.5 31a12 12 0 0 1-16.9 1.65L295.69 107.21a12.19 12.19 0 0 0-15.3 0L45.17 301a12 12 0 0 1-16.89-1.65l-25.5-31a12 12 0 0 1 1.61-16.89L257.49 43a48 48 0 0 1 61 0L408 116.61V44a12 12 0 0 1 12-12h56a12 12 0 0 1 12 12v138.51l83.6 68.91a12 12 0 0 1 1.72 16.93z"
          class="text-blue-900">
          </path>
        </g>
      </svg>
    """},
    %{name: "Cuentas", link: "/account", icon: """
    <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="home" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"
    class="h-8 w-8 ml-2 mr-auto">
      <g>
        <path fill="currentColor" d="M384 128H272a16 16 0 0 1-16-16V0H24A23.94 23.94 0 0 0 0 23.88V488a23.94 23.94 0 0 0 23.88 24H360a23.94 23.94 0 0 0 24-23.88V128zm-192 64a64 64 0 1 1-64 64 64 64 0 0 1 64-64zm112 236.8c0 10.61-10 19.2-22.4 19.2H102.4C90 448 80 439.4 80 428.8v-19.2c0-31.81 30.09-57.6 67.1-57.6h5a103.22 103.22 0 0 0 79.7 0h5c37.11 0 67.2 25.79 67.2 57.6z"
        class="text-blue-500">
        </path>
        <path fill="currentColor" d="M377 105L279.1 7a24 24 0 0 0-17-7H256v112a16 16 0 0 0 16 16h112v-6.1a23.9 23.9 0 0 0-7-16.9zM192 320a64 64 0 1 0-64-64 64 64 0 0 0 64 64zm44.8 32h-5a103.22 103.22 0 0 1-79.7 0h-5c-37 0-67.1 25.79-67.1 57.6v19.2c0 10.6 10 19.2 22.4 19.2h179.2c12.37 0 22.4-8.59 22.4-19.2v-19.2c0-31.81-30.09-57.6-67.2-57.6z"
        class="text-blue-900">
        </path>
      </g>
    </svg>
    """},
    %{name: "Activos", link: "/actives", icon: """
    <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="home" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
    class="h-8 w-8 ml-2 mr-auto">
      <g>
        <path fill="currentColor" d="M176 448a32 32 0 0 0 32 32h32a32 32 0 0 0 32-32V304h-96zm64-416h-32a32 32 0 0 0-32 32v144h96V64a32 32 0 0 0-32-32z"
          class="text-blue-500">
          </path>
        <path fill="currentColor" d="M448 240v32a32 32 0 0 1-32 32H32a32 32 0 0 1-32-32v-32a32 32 0 0 1 32-32h384a32 32 0 0 1 32 32z"
          class="text-blue-900">
        </path>
      </g>
    </svg>
    """},
    %{name: "Fiscales", link: "/fiscals", icon: """
    <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="home" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"
      class="h-8 w-8 ml-2 mr-auto">
        <g>
            <path fill="currentColor" d="M384 128H272a16 16 0 0 1-16-16V0H24A23.94 23.94 0 0 0 0 23.88V488a23.94 23.94 0 0 0 23.88 24H360a23.94 23.94 0 0 0 24-23.88V128zM64 72a8 8 0 0 1 8-8h80a8 8 0 0 1 8 8v16a8 8 0 0 1-8 8H72a8 8 0 0 1-8-8zm0 80v-16a8 8 0 0 1 8-8h80a8 8 0 0 1 8 8v16a8 8 0 0 1-8 8H72a8 8 0 0 1-8-8zm144 263.88V440a8 8 0 0 1-8 8h-16a8 8 0 0 1-8-8v-24.29a57.32 57.32 0 0 1-31.37-11.35 8 8 0 0 1-.57-12.14L155.81 381a8.22 8.22 0 0 1 10.13-.73 24.06 24.06 0 0 0 12.82 3.73h28.11c6.5 0 11.8-5.92 11.8-13.19 0-5.95-3.61-11.19-8.77-12.73l-45-13.5c-18.59-5.58-31.58-23.42-31.58-43.39 0-24.52 19.05-44.44 42.67-45.07V232a8 8 0 0 1 8-8h16a8 8 0 0 1 8 8v24.29a57.17 57.17 0 0 1 31.37 11.35 8 8 0 0 1 .57 12.14L228.18 291a8.22 8.22 0 0 1-10.13.73 24 24 0 0 0-12.82-3.73h-28.11c-6.5 0-11.8 5.92-11.8 13.19 0 5.95 3.61 11.19 8.77 12.73l45 13.5c18.59 5.58 31.58 23.42 31.58 43.39 0 24.53-19 44.44-42.67 45.07z" class="text-blue-500"></path>
            <path fill="currentColor" d="M377 105L279.1 7a24 24 0 0 0-17-7H256v112a16 16 0 0 0 16 16h112v-6.1a23.9 23.9 0 0 0-7-16.9zM219.09 327.42l-45-13.5c-5.16-1.54-8.77-6.78-8.77-12.73 0-7.27 5.3-13.19 11.8-13.19h28.11a24 24 0 0 1 12.82 3.73 8.22 8.22 0 0 0 10.13-.73l11.76-11.22a8 8 0 0 0-.57-12.14A57.17 57.17 0 0 0 208 256.29V232a8 8 0 0 0-8-8h-16a8 8 0 0 0-8 8v24.12c-23.62.63-42.67 20.55-42.67 45.07 0 20 13 37.81 31.58 43.39l45 13.5c5.16 1.54 8.77 6.78 8.77 12.73 0 7.27-5.3 13.19-11.8 13.19h-28.12a24.06 24.06 0 0 1-12.82-3.73 8.22 8.22 0 0 0-10.13.73l-11.75 11.22a8 8 0 0 0 .57 12.14A57.32 57.32 0 0 0 176 415.71V440a8 8 0 0 0 8 8h16a8 8 0 0 0 8-8v-24.12c23.67-.63 42.67-20.54 42.67-45.07 0-19.97-12.99-37.81-31.58-43.39z" class="text-blue-900"></path>
          </g>
      </svg>
    """},
    %{name: "Reportes", link: "/reports", icon: """
    <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="home" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"
      class="h-8 w-8 ml-2 mr-auto">
        <g>
            <path fill="currentColor" d="M272 128a16 16 0 0 1-16-16V0H24A23.94 23.94 0 0 0 0 23.88V488a23.94 23.94 0 0 0 23.88 24H360a23.94 23.94 0 0 0 24-23.88V128zM128 435.2c0 6.4-6.4 12.8-12.8 12.8H76.8c-6.4 0-12.8-6.4-12.8-12.8v-70.4c0-6.4 6.4-12.8 12.8-12.8h38.4c6.4 0 12.8 6.4 12.8 12.8zm96 0c0 6.4-6.4 12.8-12.8 12.8h-38.4c-6.4 0-12.8-6.4-12.8-12.8V236.8c0-6.4 6.4-12.8 12.8-12.8h38.4c6.4 0 12.8 6.4 12.8 12.8zm96 0c0 6.4-6.4 12.8-12.8 12.8h-38.4c-6.4 0-12.8-6.4-12.8-12.8V300.8c0-6.4 6.4-12.8 12.8-12.8h38.4c6.4 0 12.8 6.4 12.8 12.8z" class="text-blue-500"></path>
            <path fill="currentColor" d="M377 105L279.1 7a24 24 0 0 0-17-7H256v112a16 16 0 0 0 16 16h112v-6.1a23.9 23.9 0 0 0-7-16.9zM115.2 352H76.8c-6.4 0-12.8 6.4-12.8 12.8v70.4c0 6.4 6.4 12.8 12.8 12.8h38.4c6.4 0 12.8-6.4 12.8-12.8v-70.4c0-6.4-6.4-12.8-12.8-12.8zm96-128h-38.4c-6.4 0-12.8 6.4-12.8 12.8v198.4c0 6.4 6.4 12.8 12.8 12.8h38.4c6.4 0 12.8-6.4 12.8-12.8V236.8c0-6.4-6.4-12.8-12.8-12.8zm96 64h-38.4c-6.4 0-12.8 6.4-12.8 12.8v134.4c0 6.4 6.4 12.8 12.8 12.8h38.4c6.4 0 12.8-6.4 12.8-12.8V300.8c0-6.4-6.4-12.8-12.8-12.8z" class="text-blue-900"></path>
          </g>
      </svg>
    """}
  ]
end
