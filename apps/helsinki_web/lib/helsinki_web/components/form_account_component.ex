defmodule AccountingSystemWeb.FormAccountComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    #{:ok, socket}
    {:ok, assign(socket,
    levelx: 0,
    codex: "",
    parent_accountx: 0,
    namex: ""
    )}
  end

  def update(attrs, socket) do
    attrs |> IO.inspect(label: "-------- >  Params Arrived ->")
    values = if attrs.level == 0, do: load_values(), else: load_values_with_id(attrs.id)
    values |> IO.inspect(label: "VALUES -> -> ")

    {:ok, assign(socket,
      levelx: attrs.level,
      codex: values.code,
      parent_accountx: values.parent_account,
      root_accountx: values.root_account,
      namex: (if attrs.level == 0, do: "", else: values.name)
      )}
  end

  def load_values() do
    AccountingSystem.AccountHandler.get_principal_account!()
    |> AccountingSystem.SchemaFormatter.get_root_account()
    #|> AccountingSystem.AccountHandler.change_account_code()
  end

  def load_values_with_id(id) do
    AccountingSystem.AccountHandler.get_account_code!(id)
    |> AccountingSystem.SchemaFormatter.get_child_values()
  end

  def render(assigns) do
    ~L"""
    <div id="x" class="bg-white mt-16 ml-1 w-240 rounded border">

      <div class="inline-block bg-blue-700 text-white px-6 py-3 w-full">
        <h1 class="text-2xl font-medium text-white  block">
          Nueva Cuenta
        </h1>
        <label class="block">Nivel: <b>2</b></label>
      </div>

      <form phx-submit="save_new" phx-target="#x">
      <div class="inline-block">
        <div class="inline-flex w-full">

          <div class="px-8 py-6 flex flex-col my-2 w-160">
            <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Código</label>
            <input type="text" name="code" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" placeholder="Código" value="<%= @codex %>">

            <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Nombre</label>
            <div class="inline-flex w-full">
              <input type="text" name="name" maxlength="32" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Nombre" value="<%= @namex %>">
              <input type="text" name="name2" maxlength="32" class="focus:outline-none focus:bg-white focus:border-blue-500 ml-4 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Nombre">
            </div>
            <label class="block tracking-wide text-gray-700 font-bold" for="grid-description">Descripción</label>
            <input type="text" name="description" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-description" placeholder="Descripción">

            <label class="block tracking-wide text-gray-700 font-bold" for="grid-state">Tipo</label>
            <div class="relative mb-3">
              <select name="type" class="focus:outline-none focus:bg-white focus:border-blue-500 block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight" id="option-type">
                <option value="A">Acumulativo</option>
                <option value="D">Detalle</option>
              </select>
              <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
              </div>
            </div>
            <label class="block tracking-wide text-gray-700 font-bold" for="uuid-voucher">
              Vale Uuid
            </label>
            <input type="text" name="uuid_voucher" maxlength="32" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-uuid-voucher" placeholder="Vale Uuid">

            <div class="inline-flex w-full">
              <div class="inline-block w-full mr-2">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Código de Grupo</label>
                <input type="number" name="group_code" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Código de Grupo">
              </div>
              <div class="inline-block w-full ml-2">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Aplicar a</label>
                <input type="number" name="apply_to" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Aplicar a">
              </div>
            </div>

            <div class="inline-flex w-full">
              <div class="inline-block w-full mr-2">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Fiscar Tercero</label>
                <input type="number" name="third_party_prosecutor" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Fiscal Tercero">
              </div>
              <div class="inline-block w-full ml-2">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Aplicar Tercero a</label>
                <input type="text" name="apply_third_party_to" maxlength="2" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Aplicar Tercero a">
              </div>
            </div>

          </div>

          <div class="px-8 py-6 flex flex-col my-2 w-80">
            <div class="inline-flex items-center py-6">
              <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                <input type="checkbox" name="status" class="hidden" id="checkbox-active" checked value="A">
                <label class="relative inline bg-transparent w-10" for="checkbox-active"></label>
              </div>
              <label class="ml-2 font-bold text-gray-700">Activo</label>
            </div>
            <div class="inline-flex items-center py-6">
              <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                <input type="checkbox" name="is_departamental" class="hidden" id="checkbox-departamental">
                <label class="relative inline bg-transparent w-10" for="checkbox-departamental"></label>
              </div>
              <label class="ml-2 font-bold text-gray-700">Es Departamental</label>
            </div>
            <div class="inline-flex items-center py-6">
              <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                <input type="checkbox" name="character" class="hidden" id="checkbox-character">
                <label class="relative inline bg-transparent w-10" for="checkbox-character"></label>
              </div>
              <label class="ml-2 font-bold text-gray-700">Caracter</label>
            </div>
            <div class="inline-flex items-center py-6">
              <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                <input type="checkbox" name="third_party_op" class="hidden" id="checkbox-third-party-op">
                <label class="relative inline bg-transparent w-10" for="checkbox-third-party-op"></label>
              </div>
              <label class="ml-2 font-bold text-gray-700">Operación de Terceros</label>
            </div>
            <div class="inline-flex items-center py-6">
              <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                <input type="checkbox" name="payment_method" class="hidden" id="checkbox-payment-method">
                <label class="relative inline bg-transparent w-10" for="checkbox-payment-method"></label>
              </div>
              <label class="ml-2 font-bold text-gray-700">Método de Pago</label>
              </div>
            </div>

          </div>

          <div>
            <input type="hidden" name="parent_account" value="<%= @parent_accountx %>">
            <input type="hidden" name="root_account" value="<%= @root_accountx %>">
            <input type="hidden" name="level" value="<%= @levelx %>">
          </div>

        </div>

        <div class="w-240 absolute bottom-0 inline-block py-8 flex flex-col my-2 pr-20">
          <button class="ml-auto py-2 w-32 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
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
        </div>

      </div>


      </form>
    </div>
    """
  end

end
