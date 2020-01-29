defmodule AccountingSystemWeb.SubMenuComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
      <div class="bg-white w-64 my-3">
        <ul class="list-reset">
          <li >
            <a href="#" class="block p-4 text-grey-darker font-bold border-purple hover:bg-grey-lighter border-r-4">Crear Cuenta</a>
          </li>
          <li >
            <a href="#" class="block p-4 text-grey-darker font-bold border-grey-lighter hover:border-purple-light hover:bg-grey-lighter border-r-4">Consultar Cuenta</a>
          </li>
          <li >
            <a href="#" class="block p-4 text-grey-darker font-bold border-grey-lighter hover:border-purple-light hover:bg-grey-lighter border-r-4">Todas las Cuentas</a>
          </li>
          <li >
            <a href="#" class="block p-4 text-grey-darker font-bold border-grey-lighter hover:border-purple-light hover:bg-grey-lighter border-r-4">Servicios</a>
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
