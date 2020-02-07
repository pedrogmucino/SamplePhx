defmodule AccountingSystemWeb.FormAccountComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="bg-white mt-16 ml-1 w-240 rounded border">

      <div class="inline-block bg-blue-800 text-white px-6 py-3 w-full">
        <h1 class="text-2xl font-medium text-white  block">
          Nueva Cuenta
        </h1>
        <label class="block">Nivel: <b>2</b></label>
      </div>

      <div class="inline-flex">
        <div class="px-8 py-6 flex flex-col my-2 w-160">
          <form class="w-full">
            <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Code</label>
            <input class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Code">

            <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Name</label>
            <div class="inline-flex w-full">
              <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Name">
              <input class="ml-4 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Name">
            </div>

            <label class="block tracking-wide text-gray-700 font-bold" for="grid-description">Description</label>
            <input class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-description" type="text" placeholder="Description">

            <label class="block tracking-wide text-gray-700 font-bold" for="grid-state">Type</label>
            <div class="relative mb-3">
              <select class="block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-state">
                <option>Acumulativo</option>
                <option>Detalle</option>
              </select>
              <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
              </div>
            </div>

            <label class="block tracking-wide text-gray-700 font-bold" for="uuid-voucher">
              Uuid Voucher
            </label>
            <input class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-uuid-voucher" type="text" placeholder="Uuid Voucher">

            <div class="inline-flex w-full">
              <div class="mb-3 inline-block w-1/2 px-2">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Group Code</label>
                <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Group Code">
              </div>
              <div class="mb-3 inline-block w-1/2 px-2">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Apply to</label>
                <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Apply to">
              </div>
            </div>

            <div class="inline-flex w-full">
              <div class="mb-3 inline-block w-1/2 px-2">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Third Party Prosecutor</label>
                <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Third Party Prosecutor">
              </div>
              <div class="mb-3 inline-block w-1/2 px-2">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Apply Third Party To</label>
                <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Apply Third Party To">
              </div>
            </div>

          </form>
        </div>

        <div class="px-8 py-6 flex flex-col my-2 w-80">
          <div class="inline-flex items-center py-6">
            <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
              <input class="hidden" type="checkbox" id="checkbox-active" checked>
              <label class="relative inline bg-transparent w-10" for="checkbox-active"></label>
            </div>
            <label class="ml-2 font-bold text-gray-700">Active</label>
          </div>

          <div class="inline-flex items-center py-6">
            <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
              <input class="hidden" type="checkbox" id="checkbox-departamental">
              <label class="relative inline bg-transparent w-10" for="checkbox-departamental"></label>
            </div>
            <label class="ml-2 font-bold text-gray-700">Is Departamental</label>
          </div>

          <div class="inline-flex items-center py-6">
            <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
              <input class="hidden" type="checkbox" id="checkbox-character">
              <label class="relative inline bg-transparent w-10" for="checkbox-character"></label>
            </div>
            <label class="ml-2 font-bold text-gray-700">Character</label>
          </div>

          <div class="inline-flex items-center py-6">
            <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
              <input class="hidden" type="checkbox" id="checkbox-third-party-to">
              <label class="relative inline bg-transparent w-10" for="checkbox-third-party-to"></label>
            </div>
            <label class="ml-2 font-bold text-gray-700">Third Party To</label>
          </div>

          <div class="inline-flex items-center py-6">
            <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
              <input class="hidden" type="checkbox" id="checkbox-payment-method">
              <label class="relative inline bg-transparent w-10" for="checkbox-payment-method"></label>
            </div>
            <label class="ml-2 font-bold text-gray-700">Payment Method</label>
          </div>

        </div>
      </div>

      <div class="inline-block py-6 flex flex-col my-2">
        <button class="ml-auto mr-8 py-2 w-32 bg-teal-800 text-teal-100 items-center inline-flex font-bold rounded shadow hover:bg-teal-600 focus:shadow-outline focus:outline-none rounded" type="button">
          <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="save" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
          class="h-4 w-4 mr-2 ml-auto">
            <g class="fa-group">
              <path fill="currentColor" d="M288 352a64 64 0 1 1-64-64 64 64 0 0 1 64 64z"
              class="text-white">
              </path>
              <path fill="currentColor" d="M433.94 129.94l-83.88-83.88A48 48 0 0 0 316.12 32H48A48 48 0 0 0 0 80v352a48 48 0 0 0 48 48h352a48 48 0 0 0 48-48V163.88a48 48 0 0 0-14.06-33.94zM224 416a64 64 0 1 1 64-64 64 64 0 0 1-64 64zm96-204a12 12 0 0 1-12 12H76a12 12 0 0 1-12-12V108a12 12 0 0 1 12-12h228.52a12 12 0 0 1 8.48 3.52l3.48 3.48a12 12 0 0 1 3.52 8.48z"
              class="text-white">
              </path>
            </g>
          </svg>
          <label class="cursor-pointer mr-auto text-white">Save</label>
        </button>
      </div>


    </div>
    """
  end

end
