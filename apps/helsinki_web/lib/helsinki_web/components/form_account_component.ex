defmodule AccountingSystemWeb.FormAccountComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  def mount(socket) do
    {:ok, assign(socket,
    levelx: 0,
    codex: "",
    parent_accountx: 0,
    namex: "",
    actionx: "",
    parent_editx: %{},
    idx: 0,
    error: nil,
    valid_literals: true,
    change: false
    )}
  end

  def update(attrs, socket) do
    try do
      values = if attrs.level == 0, do: load_values(), else: load_values_with_id(attrs.id)
      {:ok, assign(socket,
      idx: attrs.id,
      levelx: attrs.level,
      codex: values.code,
      parent_accountx: values.parent_account,
      root_accountx: values.root_account,
      namex: (if attrs.level == 0, do: "", else: values.name),
      actionx: (if attrs.edit, do: "edit", else: ""),
      parent_editx: (if attrs.edit, do: attrs.parent_edit, else: %{}),
      bendiciones: attrs.bendiciones?,
      error: nil,
      change: false
      )}

    rescue _e in RuntimeError -> {:ok, socket} end
  end

  def error(message, socket) do
    Task.async(fn ->
      :timer.sleep(5500)

      assign(socket, error: nil)
      %{error: "close_error"}
    end)
    {:ok, assign(socket, error: message, change: !socket.assigns.change)}
  end

  def error_message(message, socket) do
    Task.async(fn ->
      :timer.sleep(5500)

      assign(socket, error: nil)
      %{error: "close_error"}
    end)
    {:noreply, assign(socket, error: message, change: !socket.assigns.change)}
  end

  def load_values() do
    AccountingSystem.AccountHandler.get_principal_account!()
    |> AccountingSystem.SchemaFormatter.get_root_account()
  end

  def load_values_with_id(id) do
    AccountingSystem.AccountHandler.get_account_code!(id)
    |> AccountingSystem.SchemaFormatter.get_child_values()
  end

  def render(assigns) do
    ~L"""
      <%= if @error do %>
      <div class="z-40">
        <%=live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "error_comp", message: @error, show: true, change: @change, notification_type: "error") %>
      </div>
      <%= else %>
    <div id="x" phx-hook="scroll_x"  class="bg-white mt-16 ml-1 w-240 rounded border">

      <div class="inline-flex bg-blue-700 text-white px-6 py-3 w-full">
        <div class="inline-block">
          <label class="text-2xl font-normal text-white block"><%= (if @actionx == "edit", do: "Editar Cuenta", else: "Nueva Cuenta") %></label>
          <label class="block font-medium"><b><%= (if @actionx == "edit", do: @parent_editx.name, else: String.trim_trailing(@namex, "-")) %></b></label>
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

      <div class="inline-block">
        <form id="form1" phx-submit="action_account" phx-target="#x">
          <div class="inline-block">

            <div class="inline-flex w-full">

              <div class="px-8 py-6 flex flex-col my-2 w-160">
              <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Generales</label>

              <div class="border-solid border-2 border-gray-300 p-4 rounded">

                <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Código</label>
                <input type="text" name="code" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code" placeholder="Código" value="<%= (if @actionx == "edit", do: @parent_editx.code, else: @codex) %>">

                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Nombre</label>
                <div class="inline-flex w-full">
                  <input type="text" <%= if @actionx == "edit", do: "readonly" %> name="name" maxlength="32" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Nombre" value="<%= (if @actionx == "edit", do: @parent_editx.name, else: @namex) %>">
                  <input type="text" <%= if @actionx == "edit", do: "readonly" %> name="name2" maxlength="32" class="focus:outline-none focus:bg-white focus:border-blue-500 ml-4 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Nombre">
                </div>
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-description">Descripción</label>
                <input type="text" name="description" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-description" placeholder="Descripción" value="<%= (if @actionx == "edit", do: @parent_editx.description) %>">

                <label class="block tracking-wide text-gray-700 font-bold" for="grid-state">Tipo</label>
                <div class="relative mb-3">
                  <select name="type" class="focus:outline-none focus:bg-white focus:border-blue-500 block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-2 px-4 pr-8 rounded leading-tight" id="option-type">
                    <option value="A" <%= (if @actionx == "edit", do: (if @parent_editx.type == "A", do: "selected", else: "unselected")) %> >Acumulativo</option>
                    <option value="D" <%= (if @actionx == "edit", do: (if @parent_editx.type == "D", do: "selected", else: "unselected")) %> >Detalle</option>
                  </select>
                  <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                  </div>
                </div>
              </div>

              <br>
              <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Fiscales</label>
              <div class="border-solid border-2 border-gray-300 p-4 rounded">
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">RFC</label>
                <div class="inline-flex w-full">
                  <div class="inline-block w-full mr-2">
                    <input type="text" name="rfc_literals" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Literales" value="<%= (if @actionx == "edit", do: @parent_editx.rfc_literals) %>">
                  </div>
                  <div class="inline-block w-full mr-2">
                    <input type="text" name="rfc_numeric" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Numéricos" value="<%= (if @actionx == "edit", do: @parent_editx.rfc_numeric) %>">
                  </div>
                  <div class="inline-block w-full mr-2">
                    <input type="text" name="rfc_key" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Homoclave" value="<%= (if @actionx == "edit", do: @parent_editx.rfc_key) %>">
                  </div>
                </div>

                <label class="block tracking-wide text-gray-700 font-bold" for="uuid-voucher">
                  Vale Uuid
                </label>
                <input type="text" name="uuid_voucher" maxlength="32" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-uuid-voucher" placeholder="Vale Uuid" value="<%= (if @actionx == "edit", do: @parent_editx.uuid_voucher) %>">

                <div class="inline-flex w-full">
                  <div class="inline-block w-full mr-2">
                    <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Código de Grupo</label>
                    <input type="number" name="group_code" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Código de Grupo" value="<%= (if @actionx == "edit", do: @parent_editx.group_code) %>">
                  </div>
                  <div class="inline-block w-full ml-2">
                    <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Aplicar a</label>
                    <input type="number" name="apply_to" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Aplicar a" value="<%= (if @actionx == "edit", do: @parent_editx.apply_to) %>">
                  </div>
                </div>

                <div class="inline-flex w-full">
                  <div class="inline-block w-full mr-2">
                    <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Fiscal Tercero</label>
                    <input type="number" name="third_party_prosecutor" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Fiscal Tercero"  value="<%= (if @actionx == "edit", do: @parent_editx.third_party_prosecutor) %>">
                  </div>
                  <div class="inline-block w-full ml-2">
                    <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Aplicar a Tercero</label>
                    <input type="text" name="apply_third_party_to" maxlength="2" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" placeholder="Aplicar Tercero a"  value="<%= (if @actionx == "edit", do: @parent_editx.apply_third_party_to) %>">
                  </div>
                </div>

              </div>
              </div>

              <div class="px-8 py-6 flex flex-col my-2 w-80">
                <div class="inline-flex items-center py-6">
                  <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                    <input type="checkbox" name="status" class="hidden" id="checkbox-active" <%= (if @actionx == "edit", do: (if @parent_editx.status == "A", do: "checked", else: "unchecked"), else: "checked") %> >
                    <label class="relative inline bg-transparent w-10" for="checkbox-active"></label>
                  </div>
                  <label class="ml-2 font-bold text-gray-700">Activo</label>
                </div>
                <div class="inline-flex items-center py-6">
                  <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                    <input type="checkbox" name="is_departamental" class="hidden" id="checkbox-departamental" <%= (if @actionx == "edit", do: (if @parent_editx.is_departamental, do: "checked", else: "unchecked")) %> >
                    <label class="relative inline bg-transparent w-10" for="checkbox-departamental"></label>
                  </div>
                  <label class="ml-2 font-bold text-gray-700">Es Departamental</label>
                </div>
                <div class="inline-flex items-center py-6">
                  <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                    <input type="checkbox" name="character" class="hidden" id="checkbox-character" <%= (if @actionx == "edit", do: (if @parent_editx.character, do: "checked", else: "unchecked")) %> >
                    <label class="relative inline bg-transparent w-10" for="checkbox-character"></label>
                  </div>
                  <label class="ml-2 font-bold text-gray-700">Caracter</label>
                </div>
                <div class="inline-flex items-center py-6">
                  <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                    <input type="checkbox" name="third_party_op" class="hidden" id="checkbox-third-party-op" <%= (if @actionx == "edit", do: (if @parent_editx.third_party_op, do: "checked", else: "unchecked")) %> >
                    <label class="relative inline bg-transparent w-10" for="checkbox-third-party-op"></label>
                  </div>
                  <label class="ml-2 font-bold text-gray-700">Operación de Terceros</label>
                </div>
                <div class="inline-flex items-center py-6">
                  <div class="modern-checkbox flex shadow-md h-6 w-12 rounded-full " >
                    <input type="checkbox" name="payment_method" class="hidden" id="checkbox-payment-method" <%= (if @actionx == "edit", do: (if @parent_editx.payment_method, do: "checked", else: "unchecked")) %> >
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
                <input type="hidden" name="action" value="<%= @actionx %>">
                <input type="hidden" name="id" value="<%= @idx %>">
              </div>

            </div>
          </div>
        </form>

        <div class="-mt-20 ml-mar-150">

        <%= if @actionx == "edit" && !@bendiciones do %>
        <div class="inline-block">
          <button phx-click="delete_account" phx-target="#x" phx-value-id=<%= @idx%> phx-value-delete="true" phx-value-level=<%= @levelx %>
            class="py-2 w-32 bg-red-500 text-white hover:bg-red-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
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
          </div>
        <% end %>

        <div class="inline-block">
        <button form="form1"
        class="ml-10 py-2 w-32 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
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
      <div>
      <% end %>
      </div>
    </div>
    """
  end

end
