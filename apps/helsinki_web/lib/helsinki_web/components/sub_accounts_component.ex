defmodule AccountingSystemWeb.SubAccountsComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, assign(socket, subaccounts: get_subaccounts_1())}
  end

  def update(attrs, socket) do
    #{:ok, socket}
    {:ok, assign(socket, :parent_account, attrs.parent_account)}
  end

  def render(assigns) do
    ~L"""


    <div class="bg-white h-hoch-90 w-80 float-left ml-1 mt-16 block">
      <div class=" w-full pt-6 bg-gray-200">
        <div class="block text-white px-3 text-center">
          <h1 class="text-2xl font-medium text-gray-800"> <%= @parent_account %> </h1>
          <label class="block text-gray-700 text-sm font-bold">1-1002-1010-1000</label>
          <label class="block text-gray-700">Nivel: <b>2</b></label>
          <label class="block text-gray-700">Tipo: <b>Acumulativo</b></label>
          <div class="w-full inline-flex py-2">

            <div class="w-1/2 px-2">
              <button class="py-2 bg-teal-800 text-teal-100 items-center inline-flex font-bold rounded text-sm w-full ">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
                  class="h-4 w-4 mr-2 ml-auto">
                  <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"
                  class="text-white">
                  </path>
                </svg>
                <label class="mr-auto text-white">Nueva</label>
              </button>
            </div>

            <div class="w-1/2 px-2">
              <button class="py-2 bg-gray-600 text-teal-100 items-center inline-flex font-bold rounded text-sm w-full ">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="pencil-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
                  class="h-4 w-4 mr-2 ml-auto">
                  <path fill="currentColor" d="M497.9 142.1l-46.1 46.1c-4.7 4.7-12.3 4.7-17 0l-111-111c-4.7-4.7-4.7-12.3 0-17l46.1-46.1c18.7-18.7 49.1-18.7 67.9 0l60.1 60.1c18.8 18.7 18.8 49.1 0 67.9zM284.2 99.8L21.6 362.4.4 483.9c-2.9 16.4 11.4 30.6 27.8 27.8l121.5-21.3 262.6-262.6c4.7-4.7 4.7-12.3 0-17l-111-111c-4.8-4.7-12.4-4.7-17.1 0zM124.1 339.9c-5.5-5.5-5.5-14.3 0-19.8l154-154c5.5-5.5 14.3-5.5 19.8 0s5.5 14.3 0 19.8l-154 154c-5.5 5.5-14.3 5.5-19.8 0zM88 424h48v36.3l-64.5 11.3-31.1-31.1L51.7 376H88v48z"
                  class="text-white">
                  </path>
                </svg>
                <label class="mr-auto text-white">Editar</label>
              </button>
            </div>

          </div>
        </div>

      </div>
      <div class="relative w-full px-2 mt-2">
        <input class="h-8 w-full rounded border bg-gray-300 pl-2" placeholder="Buscar Cuenta" >
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


      <%= for item <- @subaccounts do %>
      <%= if item.parent_name == @parent_account do %>
      <div class="w-full p-2 block">
        <div class="w-full block bg-gray-200 p-3 rounded relative">
          <h2 class="text-gray-700 text-xl"> <%= item.name %> </h2>
          <label class="text-gray-600 font-bold text-sm">1-001-0010-0010</label>
          <div class="absolute bg-<%= item.color_sub_account_type %>-200 px-3 text-sm font-bold top-0 right-0 rounded-full text-<%= item.color_sub_account_type %>-700 mt-2 mr-2">
            <%= item.account_type %>
          </div>
        </div>
      </div>
      <% end %>
      <% end %>
    </div>

    """
  end

  defp get_subaccounts_1(), do:
    [
      %{
        parent_name: "Cajas",
        name: "Caja Principal",
        account: "1-001-0010-0010",
        account_type: "Activo",
        color_sub_account_type: "green",
        childs_number: 5
      },
      %{
        parent_name: "Cajas",
        name: "Caja Rápida",
        account: "2-001-0010-0010",
        account_type: "Activo",
        color_sub_account_type: "green",
        childs_number: 5
      },
      %{
        parent_name: "Almacén",
        name: "Almacén 1",
        account: "3-001-0010-0010",
        account_type: "Activo",
        color_sub_account_type: "green",
        childs_number: 5
      },
      %{
        parent_name: "Bancos",
        name: "BBVA",
        account: "4-001-0010-0010",
        account_type: "Activo",
        color_sub_account_type: "green",
        childs_number: 5
      },
      %{
        parent_name: "Bancos",
        name: "Banco x",
        account: "1-001-0010-0010",
        account_type: "Pasivo",
        color_sub_account_type: "green",
        childs_number: 5
      },
      %{
        parent_name: "Clientes",
        name: "Cliente Frecuente 1",
        account: "2-001-0010-0010",
        account_type: "Pasivo",
        color_sub_account_type: "green",
        childs_number: 5
      },
      %{
        parent_name: "Proveedores",
        name: "Proveedor x",
        account: "3-001-0010-0010",
        account_type: "Pasivo",
        color_sub_account_type: "red",
        childs_number: 5
      },
      %{
        parent_name: "Documentos por pagar",
        name: "Impuestos por pagar",
        account: "4-001-0010-0010",
        account_type: "Pasivo",
        color_sub_account_type: "red",
        childs_number: 5
      },
      %{
        parent_name: "Acreedores",
        name: "Acreedor 2",
        account: "3-001-0010-0010",
        account_type: "Capital",
        color_sub_account_type: "red",
        childs_number: 5
      },
      %{
        parent_name: "Impuestos por pagar",
        name: "SAT",
        account: "4-001-0010-0010",
        account_type: "Capital",
        color_sub_account_type: "red",
        childs_number: 5
      },
      %{
        parent_name: "Capital Contable",
        name: "Ganancias x",
        account: "3-001-0010-0010",
        account_type: "Capital",
        color_sub_account_type: "blue",
        childs_number: 5
      },
      %{
        parent_name: "Patrimonio Contable",
        name: "Ahorros x",
        account: "4-001-0010-0010",
        account_type: "Capital",
        color_sub_account_type: "blue",
        childs_number: 5
      }
    ]

end
