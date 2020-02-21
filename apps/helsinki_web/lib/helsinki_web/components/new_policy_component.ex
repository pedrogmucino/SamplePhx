defmodule AccountingSystemWeb.NewPolicyComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  #alias AccountingSystem.AccountHandler, as: Account

  def render(assigns) do
    ~L"""
    <div id="x" class="bg-white mt-16 ml-1 w-full rounded border">

      <div class="inline-flex bg-blue-700 text-white px-6 py-3 w-full">
        <div class="inline-block w-full">
          <label class="text-2xl font-normal text-white block">Editar/Nueva</label>
          <label class="block font-medium"><b>Póliza</b></label>
        </div>

        <button phx-click="close" phx-target="#x" class="ml-auto h-8 -mt-1 -mr-3">
          <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
          class="h-5 w-5 ml-auto">
            <path fill="currentColor"
              d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z"
              class="">
            </path>
          </svg>
        </button>
      </div>

      <div class="inline-block w-full">
        <form id="form1" phx-submit="action_account" phx-target="#x">
          <div class="inline-block w-full">
            <div class="inline-flex w-full">

              <div class="px-8 py-6 flex flex-col my-2 w-6/12">
                <div class="inline-flex w-full">
                  <div class="inline-flex w-full">
                    <div class="inline-block w-full mr-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Tipo de Póliza</label>
                      <input type="number" name="third_party_prosecutor" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" value="">
                    </div>
                    <div class="inline-block w-full ml-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Numero de Poliza</label>
                      <input type="text" name="apply_third_party_to" maxlength="2" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    </div>
                  </div>
                  <div class="w-1/3 flex">
                    <div class="modern-checkbox flex h-6 w-full">
                      <input type="checkbox" name="auditada" class="hidden" id="checkbox-act" unchecked>
                      <label class="relative inline bg-transparent w-10" for="checkbox-act"></label>
                      <label class="ml-2 font-bold text-gray-700">Auditada</label>
                    </div>
                  </div>
                </div>

                <div class="inline-flex w-full">
                  <div class="inline-flex w-full">
                    <div class="inline-block w-full mr-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Fecha de póliza</label>
                      <input type="number" name="third_party_prosecutor" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    </div>
                    <div class="inline-block w-full ml-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Periodo</label>
                      <input type="text" name="apply_third_party_to" maxlength="2" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    </div>
                  </div>
                  <div class="w-1/3 flex">
                    <div class="modern-checkbox flex h-6 w-full">
                      <input type="checkbox" name="docs" class="hidden" id="has_documents" unchecked >
                      <label class="relative inline bg-transparent w-10" for="has_documents"></label>
                      <label class="ml-2 font-bold text-gray-700">Documentos?</label>
                    </div>
                  </div>
                </div>

                <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Ejercicio Fiscal</label>
                <input type="text" name="code" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Concepto</label>
                <input type="text" name="code" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code">
                  <br>
                  <br>
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Cuenta</label>
                <div class="inline-flex w-full">
                  <input type="text" name="name" maxlength="32" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-2/3 bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                  <input type="text" name="name2" maxlength="32" class="focus:outline-none focus:bg-white focus:border-blue-500 ml-4 appearance-none w-1/3 bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                </div>

                <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Concepto</label>
                <input type="text" name="code" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code">

                <div class="inline-flex w-full">
                  <div class="inline-flex w-full">
                    <div class="inline-block w-full mr-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Departamento</label>
                      <input type="number" name="third_party_prosecutor" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" value="">
                    </div>
                    <div class="inline-block w-full ml-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Debe</label>
                      <input type="text" name="apply_third_party_to" maxlength="2" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    </div>
                    <div class="inline-block w-full ml-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Haber</label>
                      <input type="text" name="apply_third_party_to" maxlength="2" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    </div>
                  </div>
                </div>
              </div>

              <!-------------------------------------------AUXILIARES---------------------------------------------------->

              <div class="px-8 py-6 flex flex-col my-2 w-6/12">
                <div class="inline-flex items-center py-6">
                  <!---------------------------INFO AQUI-------------------------------------->
                    <div class="w-full px-2 block">
                      <div phx-click="open_series" phx-value-id="" phx-target="#one" class="border cursor-pointer w-full block bg-gray-200 p-3 mt-2 rounded relative hover:bg-gray-300">
                        <h2 class="text-gray-700 text-xl">Serie: </h2>
                        <label class="inline-block cursor-pointer text-gray-600 font-bold text-sm">Folio Actual: <b>9999</b></label>
                        <label class="ml-10 inline-block cursor-pointer text-gray-600 font-bold text-sm">Tipo: <b>Item.name</b></label>
                      </div>
                    </div>
                </div>

              </div>
            </div>
          </div>
        </form>

        <div class="pt-32">

        <button form="form1" class="ml-mar-120 py-2 w-32 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
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
              <label class="cursor-pointer mr-auto text-white">Guardar</label>
          </button>


        <%= if "edit" == "edit" do %>
          <button phx-click="delete_account" phx-target="#x" phx-value-id=1 phx-value-delete="true"
            class="ml-10 py-2 w-32 bg-red-500 text-white hover:bg-red-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
            <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="trash-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
              class="h-4 w-4 mr-2 ml-auto">
              <g class="fa-group">
                <path fill="currentColor" d="M32 464a48 48 0 0 0 48 48h288a48 48 0 0 0 48-48V96H32zm272-288a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0zm-96 0a16 16 0 0 1 32 0v224a16 16 0 0 1-32 0z"
                  class="fa-secondary">
                </path>
                <path fill="currentColor" d="M432 32H312l-9.4-18.7A24 24 0 0 0 281.1 0H166.8a23.72 23.72 0 0 0-21.4 13.3L136 32H16A16 16 0 0 0 0 48v32a16 16 0 0 0 16 16h416a16 16 0 0 0 16-16V48a16 16 0 0 0-16-16zM128 160a16 16 0 0 0-16 16v224a16 16 0 0 0 32 0V176a16 16 0 0 0-16-16zm96 0a16 16 0 0 0-16 16v224a16 16 0 0 0 32 0V176a16 16 0 0 0-16-16zm96 0a16 16 0 0 0-16 16v224a16 16 0 0 0 32 0V176a16 16 0 0 0-16-16z"
                  class="fa-primary">
                </path>
              </g>
            </svg>
            <label class="cursor-pointer mr-auto text-white">Eliminar</label>
          </button>
        <% end %>


        </div>
      <div>

    </div>
    """
  end
end
