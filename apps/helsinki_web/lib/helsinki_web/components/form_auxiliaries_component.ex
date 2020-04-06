defmodule AccountingSystemWeb.FormAuxiliariesComponent do
  @moduledoc """
  Componente Form Auxiliaries Component
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
      <div id="formauxiliaries" class="bg-white mt-16 ml-16 w-80 h-hoch-93 rounded border float-left">
        <div class="w-full py-2 bg-blue-700">
          <p class="ml-2 font-bold text-lg text-white">Auxiliares</p>
        </div>

        <div class="py-2">
          <p class="ml-2 font-bold text-lg text-black">Cuenta</p>
          <div class="m-2 border-solid border-2 border-gray-300 p-4 rounded">
            <label class="block"><b>Desde</b></label>
            <div class="relative mb-3">
              <select name="type" class="focus:outline-none focus:bg-white focus:border-blue-500 block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight" id="option-type">
                <option value="A">EJEMPLO 1</option>
                <option value="D">EJEMPLO 2</option>
              </select>
              <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
              </div>
            </div>
            <label class="block"><b>Hasta</b></label>
            <div class="relative mb-3">
              <select name="type" class="focus:outline-none focus:bg-white focus:border-blue-500 block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight" id="option-type">
                <option value="A">EJEMPLO 3</option>
                <option value="D">EJEMPLO 4</option>
              </select>
              <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
              </div>
            </div>
          </div>
        </div>

        <div class="py-2">
          <p class="ml-2 font-bold text-lg text-black">Periodo</p>
          <div class="m-2 border-solid border-2 border-gray-300 p-4 rounded">
            <label class="block"><b>Fecha Inicio</b></label>
            <input type="date" name="start_date" value="" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white">
            <label class="block"><b>Fecha Fin</b></label>
            <input type="date" name="start_date" value="" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white">
            <div class="mt-4 mb-4 -ml-4 -mr-4 border-t-2 border-gray-300"></div>
            <label class="block"><b>Periodo</b></label>
            <div class="relative mb-3">
              <select name="type" class="focus:outline-none focus:bg-white focus:border-blue-500 block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight" id="option-type">
                <option value="A">EJEMPLO 1</option>
                <option value="D">EJEMPLO 2</option>
              </select>
              <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
              </div>
            </div>
          </div>
        </div>

        <div class="py-2">
          <button class="ml-mar-17 border tooltip w-10 h-hoch-2 bg-teal-500 rounded text-white hover:bg-teal-400 phx-target="#formauxiliaries">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="share-square" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"
              class="h-6 w-6 ml-2">
              <path fill="currentColor" d="M568.482 177.448L424.479 313.433C409.3 327.768 384 317.14 384 295.985v-71.963c-144.575.97-205.566 35.113-164.775 171.353 4.483 14.973-12.846 26.567-25.006 17.33C155.252 383.105 120 326.488 120 269.339c0-143.937 117.599-172.5 264-173.312V24.012c0-21.174 25.317-31.768 40.479-17.448l144.003 135.988c10.02 9.463 10.028 25.425 0 34.896zM384 379.128V448H64V128h50.916a11.99 11.99 0 0 0 8.648-3.693c14.953-15.568 32.237-27.89 51.014-37.676C185.708 80.83 181.584 64 169.033 64H48C21.49 64 0 85.49 0 112v352c0 26.51 21.49 48 48 48h352c26.51 0 48-21.49 48-48v-88.806c0-8.288-8.197-14.066-16.011-11.302a71.83 71.83 0 0 1-34.189 3.377c-7.27-1.046-13.8 4.514-13.8 11.859z" class="">
              </path>
            </svg>
            <span class='tooltip-text text-white bg-blue-500 mt-5 -ml-10 rounded'>Buscar</span>
          </button>
        </div>

      </div>
    """
  end
end
