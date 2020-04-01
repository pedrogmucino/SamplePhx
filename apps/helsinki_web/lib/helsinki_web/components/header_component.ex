defmodule AccountingSystemWeb.HeaderComponent do
  @moduledoc """
  Componente con menú principal
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
    <div class="fixed w-full py-2 bg-blue-700 top-0 left-0 z-20 border-b-2 border-blue-100">
      <div class="flex">
        <img src="https://santiago.mx/assets/images/logo-white.png" class="w-56 ml-6">

        <div class="ml-auto block text-right">
          <p class="font-bold text-lg text-white ">Sebastian Stan</p>
          <p class="text-medium text-white ">Administrador contable</p>
        </div>
        <div class="inline-flex items-center ml-4 mr-4">
          <img src="https://cdn.vox-cdn.com/thumbor/24I1h6pROyMIB1-bRTHG4MSlkko=/0x0:1200x600/1200x800/filters:focal(552x137:744x329)/cdn.vox-cdn.com/uploads/chorus_image/image/58955377/Winter_Soldier.0.jpg" alt="https://cdn.vox-cdn.com/thumbor/24I1h6pROyMIB1-bRTHG4MSlkko=/0x0:1200x600/1200x800/filters:focal(552x137:744x329)/cdn.vox-cdn.com/uploads/chorus_image/image/58955377/Winter_Soldier.0.jpg" class="rounded-sm w-12 h-10">
        </div>
        <div class="border-r-2 border-gray-500"></div>

        <div class="mt-3 mr-2 cursor-pointer tooltip">
          <a href= "/listconfiguration">
            <svg aria-hidden="true" focusable="false" data-prefix="fal" data-icon="cog" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
              class="h-6 w-6 ml-2 mr-auto">
              <path fill="currentColor" d="M482.696 299.276l-32.61-18.827a195.168 195.168 0 0 0 0-48.899l32.61-18.827c9.576-5.528 14.195-16.902 11.046-27.501-11.214-37.749-31.175-71.728-57.535-99.595-7.634-8.07-19.817-9.836-29.437-4.282l-32.562 18.798a194.125 194.125 0 0 0-42.339-24.48V38.049c0-11.13-7.652-20.804-18.484-23.367-37.644-8.909-77.118-8.91-114.77 0-10.831 2.563-18.484 12.236-18.484 23.367v37.614a194.101 194.101 0 0 0-42.339 24.48L105.23 81.345c-9.621-5.554-21.804-3.788-29.437 4.282-26.36 27.867-46.321 61.847-57.535 99.595-3.149 10.599 1.47 21.972 11.046 27.501l32.61 18.827a195.168 195.168 0 0 0 0 48.899l-32.61 18.827c-9.576 5.528-14.195 16.902-11.046 27.501 11.214 37.748 31.175 71.728 57.535 99.595 7.634 8.07 19.817 9.836 29.437 4.283l32.562-18.798a194.08 194.08 0 0 0 42.339 24.479v37.614c0 11.13 7.652 20.804 18.484 23.367 37.645 8.909 77.118 8.91 114.77 0 10.831-2.563 18.484-12.236 18.484-23.367v-37.614a194.138 194.138 0 0 0 42.339-24.479l32.562 18.798c9.62 5.554 21.803 3.788 29.437-4.283 26.36-27.867 46.321-61.847 57.535-99.595 3.149-10.599-1.47-21.972-11.046-27.501zm-65.479 100.461l-46.309-26.74c-26.988 23.071-36.559 28.876-71.039 41.059v53.479a217.145 217.145 0 0 1-87.738 0v-53.479c-33.621-11.879-43.355-17.395-71.039-41.059l-46.309 26.74c-19.71-22.09-34.689-47.989-43.929-75.958l46.329-26.74c-6.535-35.417-6.538-46.644 0-82.079l-46.329-26.74c9.24-27.969 24.22-53.869 43.929-75.969l46.309 26.76c27.377-23.434 37.063-29.065 71.039-41.069V44.464a216.79 216.79 0 0 1 87.738 0v53.479c33.978 12.005 43.665 17.637 71.039 41.069l46.309-26.76c19.709 22.099 34.689 47.999 43.929 75.969l-46.329 26.74c6.536 35.426 6.538 46.644 0 82.079l46.329 26.74c-9.24 27.968-24.219 53.868-43.929 75.957zM256 160c-52.935 0-96 43.065-96 96s43.065 96 96 96 96-43.065 96-96-43.065-96-96-96zm0 160c-35.29 0-64-28.71-64-64s28.71-64 64-64 64 28.71 64 64-28.71 64-64 64z"
              class="text-white">
              </path>
            </svg>
          </a>
          <span class='tooltip-text text-white bg-blue-500 mt-8 -ml-20 rounded'>Configuración</span>
        </div>
      </div>
    </div>

    <div class="fixed top-0 left-0 h-screen px-2 bg-white block z-10 shadow-lg transition-menu w-16">
        <div class="block h-24"></div>
        <%= for item <- @menu do %>
        <div class="block my-3">
          <a href="<%= item.link %>" class="rounded hover:border-gray-200 text-gray-800 hover:bg-gray-200 py-1 inline-flex items-center w-full">
            <%= Phoenix.HTML.raw(item.icon ) %>
            <label class="cursor-pointer ml-2 mr-auto font-bold transition-menu-label"><%= item.name %></label>
          </a>
        </div>
        <% end %>
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
    %{name: "Pólizas", link: "/policylist", icon: """
    <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="line-columns" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
    class="h-8 w-8 ml-2 mr-auto">
      <g>
        <path fill="currentColor" d="M496 288H304a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h192a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16zm0 128H304a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h192a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16zm0-256H304a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h192a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16zm0-128H304a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h192a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16z"
        class="text-blue-500">
        </path>
        <path fill="currentColor" d="M208 288H16a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h192a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16zm0 128H16a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h192a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16zm0-384H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h192a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16zm0 128H16a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h192a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16z"
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
    """},
    %{name: "Series", link: "/series", icon: """
    <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="sort-numeric-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
      class="h-8 w-8 ml-2 mr-auto">
        <g>
          <path fill="currentColor" d="M304 96h16v64h-16a16 16 0 0 0-16 16v32a16 16 0 0 0 16 16h96a16 16 0 0 0 16-16v-32a16 16 0 0 0-16-16h-16V48a16 16 0 0 0-16-16h-48a16 16 0 0 0-14.29 8.83l-16 32A16 16 0 0 0 304 96zm26.15 162.91a79 79 0 0 0-55 54.17c-14.25 51.05 21.21 97.77 68.85 102.53a84.07 84.07 0 0 1-20.85 12.91c-7.57 3.4-10.8 12.47-8.18 20.34l9.9 20c2.87 8.63 12.53 13.49 20.9 9.91 58-24.76 86.25-61.61 86.25-132V336c-.02-51.21-48.4-91.34-101.85-77.09zM352 356a20 20 0 1 1 20-20 20 20 0 0 1-20 20z" class="text-blue-500"></path>
          <path fill="currentColor" d="M176 352h-48V48a16 16 0 0 0-16-16H80a16 16 0 0 0-16 16v304H16c-14.19 0-21.36 17.24-11.29 27.31l80 96a16 16 0 0 0 22.62 0l80-96C197.35 369.26 190.22 352 176 352z" class="text-blue-900"></path>
        </g>
    </svg>
    """},
    %{name: "Periodos", link: "/periods", icon: """
      <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="calendar-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="h-8 w-8 ml-2 mr-auto">
        <g>
          <path fill="currentColor" d="M0 192v272a48 48 0 0 0 48 48h352a48 48 0 0 0 48-48V192zm128 244a12 12 0 0 1-12 12H76a12 12 0 0 1-12-12v-40a12 12 0 0 1 12-12h40a12 12 0 0 1 12 12zm0-128a12 12 0 0 1-12 12H76a12 12 0 0 1-12-12v-40a12 12 0 0 1 12-12h40a12 12 0 0 1 12 12zm128 128a12 12 0 0 1-12 12h-40a12 12 0 0 1-12-12v-40a12 12 0 0 1 12-12h40a12 12 0 0 1 12 12zm0-128a12 12 0 0 1-12 12h-40a12 12 0 0 1-12-12v-40a12 12 0 0 1 12-12h40a12 12 0 0 1 12 12zm128 128a12 12 0 0 1-12 12h-40a12 12 0 0 1-12-12v-40a12 12 0 0 1 12-12h40a12 12 0 0 1 12 12zm0-128a12 12 0 0 1-12 12h-40a12 12 0 0 1-12-12v-40a12 12 0 0 1 12-12h40a12 12 0 0 1 12 12zm-80-180h32a16 16 0 0 0 16-16V16a16 16 0 0 0-16-16h-32a16 16 0 0 0-16 16v96a16 16 0 0 0 16 16zm-192 0h32a16 16 0 0 0 16-16V16a16 16 0 0 0-16-16h-32a16 16 0 0 0-16 16v96a16 16 0 0 0 16 16z" class="text-blue-500"></path>
          <path fill="currentColor" d="M448 112v80H0v-80a48 48 0 0 1 48-48h48v48a16 16 0 0 0 16 16h32a16 16 0 0 0 16-16V64h128v48a16 16 0 0 0 16 16h32a16 16 0 0 0 16-16V64h48a48 48 0 0 1 48 48z" class="text-blue-900"></path>
        </g>
      </svg>
    """}
  ]
end
