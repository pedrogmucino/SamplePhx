defmodule AccountingSystemWeb.FormAccountComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="bg-white mt-16 ml-1 w-160 rounded border">

      <div class="inline-block bg-blue-800 text-white px-6 py-3 w-full">
        <h1 class="text-2xl font-medium text-white  block">
          Nueva Cuenta
        </h1>
        <label class="block">Nivel: <b>2</b></label>
      </div>

      <div class="px-8 py-6 flex flex-col my-2 >
        <form class="w-full max-w-lg">

        <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">
          Code
        </label>
        <input class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" type="text" placeholder="Code">

        <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">
          Name
        </label>
        <div class="inline-flex">
          <input class="appearance-none w-48 bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Name">
          <input class="ml-4 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Name">
        </div>

        <label class="block tracking-wide text-gray-700 font-bold" for="grid-description">
          Description
        </label>
        <input class="appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-description" type="text" placeholder="Description">

        <label class="block tracking-wide text-gray-700 font-bold" for="grid-state">
          Type
        </label>
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



        <div class="inline-flex">
          <div class="mb-3 inline-block w-1/4 px-2">
            <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Level</label>
            <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Level">
          </div>

          <div class="mb-3 inline-block w-1/4 px-2">
            <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Level</label>
            <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Level">
          </div>

          <div class="mb-3 inline-block w-1/4 px-2">
            <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Level</label>
            <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Level">
          </div>

          <div class="mb-3 inline-block w-1/4 px-2">
            <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Level</label>
            <input class="appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" type="text" placeholder="Level">
          </div>

        </div>


        <div class="inline-flex">
          <div class="mb-3 inline-block">
            <div class="inline-flex items-center">
              <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                <input class="hidden" type="checkbox" id="checkbox-1">
                <label class="relative inline bg-transparent w-10" for="checkbox-1">
                </label>
              </div>
              <label class="ml-2 font-bold text-gray-700">Active</label>
            </div>

            <div class="py-2 form-switch block align-middle">
              <input type="checkbox" name="1" id="1" class="form-switch-checkbox" checked />
              <label class="ml-2 text-gray-700 font-bold">Active</label>
            </div>
            <div class="py-2 form-switch block align-middle">
              <input type="checkbox" name="1" id="1" class="form-switch-checkbox" />
              <label class="ml-2 text-gray-700 font-bold">Character</label>
            </div>
            <div class="py-2 form-switch block align-middle">
              <input type="checkbox" name="1" id="1" class="form-switch-checkbox" />
              <label class="ml-2 text-gray-700 font-bold">Third Party To</label>
            </div>
          </div>

          <div class="ml-32 mb-3 inline-block">
            <div class="py-2 form-switch block align-middle">
              <input type="checkbox" name="1" id="1" class="form-switch-checkbox" />
              <label class="ml-2 text-gray-700 font-bold">Is Departamental</label>
            </div>
            <div class="py-2 form-switch block align-middle">
              <input type="checkbox" name="1" id="1" class="form-switch-checkbox" />
              <label class="ml-2 text-gray-700 font-bold">Payment Method</label>
            </div>
          </div>
        </div>

        </form>
      <div>


    </div>
    """
  end

end
