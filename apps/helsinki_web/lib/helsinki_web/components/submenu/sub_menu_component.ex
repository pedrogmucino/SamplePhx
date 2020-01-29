defmodule AccountingSystemWeb.SubMenuComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div class="bg-white w-48">
        <ul>
          <li class="cursor-pointer hover:bg-gray-200 hover:border-blue-500 border-r-4">
            <a href="#" class="block py-2 mr-auto font-bold text-blue-500 ml-2" >Crear Cuenta</a>
          </li>
          <li class="cursor-pointer hover:bg-gray-200 hover:border-blue-500 border-r-4">
            <a href="#" class="block py-2 mr-auto font-bold text-blue-500 ml-2" >Consultar Cuenta</a>
          </li>
          <li class="cursor-pointer hover:bg-gray-200 hover:border-blue-500 border-r-4">
            <a href="#" class="block py-2 mr-auto font-bold text-blue-500 ml-2" >Todas las Cuentas</a>
          </li>
          <li class="cursor-pointer hover:bg-gray-200 hover:border-blue-500 border-r-4">
            <a href="#" class="block py-2 mr-auto font-bold text-blue-500 ml-2" >Servicios</a>
          </li>
        </ul>
      </div>
    """
  end
  def mount(socket) do
    {:ok, socket}
  end

  def update(_attrs, socket) do
      {:ok, socket}
  end

end
