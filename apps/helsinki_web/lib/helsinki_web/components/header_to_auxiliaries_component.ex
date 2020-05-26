defmodule AccountingSystemWeb.HeaderToAuxiliariesComponent do
  @moduledoc """
  Componente Form HeaderToAuxiliaries Component
  """
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def update(_attrs, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="auxiliaries_header" class="fixed ml-mar-95 mt-16 w-full bg-white h-40">
      <div class="w-full bg-blue-700 py-2 h-hoch-121">
        <button phx-click="close" phx-target="#auxiliaries_list" class="ml-mar-377 mt-2 text-white font-bold rounded shadow">
          <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="h-5 w-5 ml-auto">
            <path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z" class=""></path>
          </svg>
        </button>
      </div>
      <div class="m-4 w-365 border-t-2 border-gray-300"></div>
        <table class="ml-4">
          <thead>
            <tr>
              <th class="w-56 px-4 py-1">Tipo Póliza</th>
              <th class="w-32 px-4 py-1">Número Póliza</th>
              <th class="w-32 px-4 py-1">Fecha</th>
              <th class="w-80 px-4 py-1">Cuenta Detalle</th>
              <th class="w-40 px-4 py-1">Caja</th>
              <th class="w-40 px-4 py-1">Abono</th>
              <th class="w-82 px-4 py-1">Concepto</th>
            </tr>
          </thead>
        </table>
    <div>
    """
  end

end
