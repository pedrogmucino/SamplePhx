defmodule AccountingSystemWeb.NewPolicyComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AccountingSystem.{
    PolicyHandler,
    PolicySchema
  }

  #alias AccountingSystem.AccountHandler, as: Account

  def render(assigns) do
    ~L"""
    <%= if @cancel? do %>
      <%= live_component(@socket, AccountingSystemWeb.ConfirmationComponent, id: "confirmation", message: @message_confirm, show: true) %>
    <% end %>
    <div id="policy" class="bg-white mt-16 ml-1 w-full rounded border">

      <div class="inline-flex bg-blue-700 text-white px-6 py-3 w-full">
        <div class="inline-block w-full">
          <label class="text-2xl font-normal text-white block"> <%= (if @edit, do: "Editar", else: "Nueva Póliza") %></label>
          <label class="block font-medium"><b> <%= (if @edit, do: "#{@pollys.serial}#{"-"}#{@pollys.policy_number}") %> </b></label>
        </div>

        <button phx-click="close" phx-target="#policy" class="ml-auto h-8 -mt-1 -mr-3">
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
          <div class="inline-block w-full">
            <div class="inline-flex w-full">
              <div class="px-8 py-6 flex flex-col my-2 w-6/12">
              <form id="form1" phx-submit= <%= (if @edit, do: "edit_and_save_this", else: "action_account")%> phx-target="#one" phx-change="update_form">
                <div class="inline-flex w-full">
                  <div class="inline-flex w-full">
                    <div class="inline-block w-full mr-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Tipo de Póliza: <%=@pollys.policy_type%></label>
                      <select <%= if !@status, do: 'disabled' %> name="policy_type" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white">
                        <%= for item <- @policytypes do %>
                          <option <%=if String.to_integer(@pollys.policy_type) == item[:value] do %> selected <% end %> value="<%= item[:value] %>"><%= item[:key] %></option>
                        <% end %>
                      </select>
                    </div>
                    <div class="inline-block w-full ml-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Fecha de póliza</label>
                      <input <%= if !@status, do: 'disabled' %> type="date" name="policy_date" value="<%=@pollys.policy_date%>" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    </div>
                  </div>
                  <div class="w-1/3 flex">
                    <div class="modern-checkbox flex h-6 w-full">
                      <input <%= if !@status, do: 'disabled' %> type="checkbox" name="audited" class="hidden" id="checkbox-act" value="<%=@pollys.audited %>" <%=@pollys.audited %>>
                      <label class="relative inline bg-transparent w-10" for="checkbox-act"></label>
                      <label class="ml-2 font-bold text-gray-700">Auditada</label>
                    </div>
                  </div>
                </div>

                <div class="inline-flex w-full">
                  <div class="inline-flex w-full">
                    <div class="inline-block w-full mr-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Ejercicio Fiscal</label>
                      <input <%= if !@status, do: 'disabled' %> type="number" name="fiscal_exercise" value="<%= @pollys.fiscal_exercise %>" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    </div>
                    <div class="inline-block w-full ml-2">
                      <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Periodo</label>
                      <input <%= if !@status, do: 'disabled' %> type="number" name="period" value="<%=@pollys.period%>" maxlength="2" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    </div>
                  </div>
                  <div class="w-1/3 flex">
                    <div class="modern-checkbox flex h-6 w-full">
                      <input <%= if !@status, do: 'disabled' %> type="checkbox" name="has_documents" class="hidden" id="checkbox-act2" value="<%=@pollys.has_documents %>" <%=@pollys.has_documents %> >
                      <label class="relative inline bg-transparent w-10" for="checkbox-act2"></label>
                      <label class="ml-2 font-bold text-gray-700">Documentos?</label>
                    </div>
                  </div>
                </div>
                <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Concepto</label>
                <input <%= if !@status, do: 'disabled' %> type="text" name="concept" value="<%=@pollys.concept%>" phx-target="#one" phx-keyup="focused_concept" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code">
                <input type="hidden" name="id" value="<%=@pollys.id%>">
              </form>

              <div class="mt-10 py-6">
                <div class="py-2">
                  <label><b>Captura de Auxiliares</b></label>
                </div>
                <div class="border-solid border-2 border-gray-300 p-2">
                <form id="form2" phx-submit="save_aux" phx-target="#one" phx-change="update_form" class="-mt-32">
                  <label class="block pt-32 tracking-wide text-gray-700 font-bold" for="grid-name">Cuenta</label>
                  <div class="inline-flex w-full">
                    <div class="w-2/3 relative">
                      <input <%= if !@status, do: 'disabled' %> class="hidden" name="id_account" value="<%= @pollys.id_account %>">
                      <input <%= if !@status, do: 'disabled' %> class="hidden" name="id_aux" value="<%= @pollys.id_aux %>">
                      <input <%= if !@status, do: 'disabled' %> autocomplete="off" type="text" phx-target="#one" phx-keyup="show_accounts" phx-focus="account_focused" name="account" value="<%=@pollys.account%>" maxlength="256" class="focus:outline-none focus:bg-white focus:border-blue-500 w-full appearance-none  bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white">
                      <%= if length(@dropdowns) > 0 and @pollys.focused == 1 do %>
                        <div class="w-full block absolute top-0 left-0 z-10 mt-10 bg-gray-100 overflow-y-scroll h-64">
                          <%= for item <- @dropdowns do %>
                            <div phx-target="#one" phx-click="autocomplete" phx-value-id="<%= item.value %>" phx-value-account="<%=List.first(item.key)%>" phx-value-name="<%=List.last(item.key)%>" class="block py-1 px-3 hover:bg-gray-500 hover:text-white cursor-pointer">
                                <%= List.to_string(item.key) %>
                            </div>
                          <% end %>
                        </div>
                      <% end %>
                    </div>
                    <input <%= if !@status, do: 'disabled' %> type="text" name="name" maxlength="128" value="<%=@pollys.name%>" class="focus:outline-none focus:bg-white focus:border-blue-500 ml-4 appearance-none w-1/3 bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                    <a href="/account" target="_blank" class="tooltip w-10 h-hoch-2 px-4 ml-2 bg-teal-500 text-white text-center hover:bg-teal-400 border rounded">
                      <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="layer-plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
                        class="h-6 w-6 mr-auto -ml-2 mt-1"><path fill="currentColor" d="M492.88 354.58L413.19 320l79.68-34.58c12.16-5.28 17.72-19.41 12.47-31.56-5.28-12.17-19.38-17.67-31.59-12.47l-217.22 94.72L71.91 256l170.5-73.98c12.16-5.28 17.72-19.41 12.47-31.56-5.28-12.19-19.38-17.67-31.59-12.47L19.16 226.56C7.53 231.59 0 243.16 0 256s7.53 24.41 19.12 29.42L98.82 320l-79.67 34.56C7.53 359.59 0 371.16 0 384.02c0 12.84 7.53 24.41 19.12 29.42l218.28 94.69a46.488 46.488 0 0 0 18.59 3.88c6.34-.02 12.69-1.3 18.59-3.86l218.25-94.69c11.62-5.03 19.16-16.59 19.16-29.44.01-12.86-7.52-24.43-19.11-29.44zM256.53 464.11L71.91 384l87.22-37.84 78.28 33.96c5.91 2.58 12.25 3.86 18.59 3.86s12.69-1.28 18.59-3.84l78.3-33.98 87.29 37.88-183.65 80.07zM496 88h-72V16c0-8.84-7.16-16-16-16h-16c-8.84 0-16 7.16-16 16v72h-72c-8.84 0-16 7.16-16 16v16c0 8.84 7.16 16 16 16h72v72c0 8.84 7.16 16 16 16h16c8.84 0 16-7.16 16-16v-72h72c8.84 0 16-7.16 16-16v-16c0-8.84-7.16-16-16-16z" class=""></path>
                      </svg>
                      <span class='tooltip-text text-white bg-blue-500 mt-5 -ml-12 rounded'>Nueva Cuenta</span>
                    </a>
                  </div>

                  <label class="block tracking-wide text-gray-700 font-bold" for="grid-code">Concepto</label>
                  <input <%= if !@status, do: 'disabled' %> type="text" name="aux_concept" value="<%=@pollys.aux_concept%>" maxlength="128" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none block w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-code">

                  <div class="inline-flex w-full">
                    <div class="inline-flex w-full flex">
                      <div class="inline-block mr-2 w-1/6">
                        <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Departamento</label>
                        <input <%= if !@status, do: 'disabled' %> type="number" name="department" value="<%=@pollys.department%>" min="1" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name" value="">
                      </div>
                      <div class="inline-block ml-2 w-2/6">
                        <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Debe</label>
                        <input <%= if !@status, do: 'disabled' %> type="number" name="debit" step="0.01" min="0" max="999999.99" phx-hook="format_number" value="<%=@pollys.debit%>" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                      </div>
                      <div class="inline-block ml-2 w-2/6">
                        <label class="block tracking-wide text-gray-700 font-bold" for="grid-name">Haber</label>
                        <input <%= if !@status, do: 'disabled' %> type="number" name="credit" step="0.01" min="0" max="999999.99" phx-hook="format_number" value="<%=@pollys.credit%>" class="focus:outline-none focus:bg-white focus:border-blue-500 appearance-none w-full bg-gray-200 text-gray-700 border rounded py-2 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" id="grid-name">
                      </div>
                      <div class="inline-block mt-6 ml-2 text-right w-1/6">
                        <button <%= if !@status, do: 'disabled' %> name="save_aux" class="bg-teal-500 text-white text-center hover:bg-teal-400 phx-target="#one" border rounded">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="share-square" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" class="h-6 w-6 m-1"><path fill="currentColor" d="M568.482 177.448L424.479 313.433C409.3 327.768 384 317.14 384 295.985v-71.963c-144.575.97-205.566 35.113-164.775 171.353 4.483 14.973-12.846 26.567-25.006 17.33C155.252 383.105 120 326.488 120 269.339c0-143.937 117.599-172.5 264-173.312V24.012c0-21.174 25.317-31.768 40.479-17.448l144.003 135.988c10.02 9.463 10.028 25.425 0 34.896zM384 379.128V448H64V128h50.916a11.99 11.99 0 0 0 8.648-3.693c14.953-15.568 32.237-27.89 51.014-37.676C185.708 80.83 181.584 64 169.033 64H48C21.49 64 0 85.49 0 112v352c0 26.51 21.49 48 48 48h352c26.51 0 48-21.49 48-48v-88.806c0-8.288-8.197-14.066-16.011-11.302a71.83 71.83 0 0 1-34.189 3.377c-7.27-1.046-13.8 4.514-13.8 11.859z" class=""></path></svg>
                        </button>
                      </div>
                    </div>
                  </div>
                </form>
                </div>
              </div>

                <!---------------------------------GUARDAR - ELIMINAR -------------------------------------->
                <div class="pt-24 grid grid-cols-2 flex">
                  <div class="flex-1 text-center">
                  <%=if @pollys.total != 0 or length(@arr) == 0 do %>
                    <button form="form1" disabled class="opacity-50 cursor-not-allowed py-2 w-1/2 bg-teal-500 text-white items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
                  <% else %>
                    <button form="form1" class="py-2 w-1/2 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
                  <% end %>
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
                        <label class="<%=if @pollys.total != 0 or length(@arr) == 0, do: "cursor-not-allowed", else: "cursor-pointer" %> mr-auto text-white">Guardar</label>
                    </button>
                  </div>
                  <div class="flex-1 text-center">
                  <%= if @edit do %>
                      <button phx-click="delete_policy" phx-target="#policy" phx-value-id="<%=@pollys.id%>" phx-value-delete="true"
                        class="py-2 w-1/2 bg-red-500 text-white hover:bg-red-400 items-center inline-flex font-bold rounded shadow focus:shadow-outline focus:outline-none rounded">
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
                        <label class="cursor-pointer mr-auto text-white">Cancelar</label>
                      </button>
                    <% end %>
                  </div>
                </div>
                <!---------------------------------------------END GUARDAR - ELIMINAR --------------------->
              </div>
              <!-------------------------------------------AUXILIARES DIV PART 2---------------------------------------------------->
              <div class="px-8 flex flex-col my-2 w-6/12">
                <div class="block text-left pl-16">
                  <label class="tracking-wide text-gray-700 font-bold" for="grid-name">Detalle</label>
                </div>

                <!---------------------DIV DE TODA LA INFO------------------------->
                  <div class="inline-flex">
                    <div class="mr-4 border-l-2 border-gray-300"></div>
                    <div class="overflow-y-auto h-hoch-70 block w-full">
                      <%= for item <- Enum.reverse(@arr) do %>
                        <div class="w-full inline-flex items-center gap-4"> <!-------Este es el div que se va a dividir en 3---->
                          <div class="w-1/12">
                            <%= item.id %>
                          </div>
                          <!---------------------------INFO AQUI---------------------------------------->
                          <div class="w-full gap-4">
                            <div phx-value-id="" phx-target="#policy" class="border cursor-pointer bg-gray-200 p-2 mt-2 rounded relative hover:bg-gray-300">
                              <div class="text-right">
                                <label class="text-gray-600 text-right">Cta: <b><%= item.account %></b></label><br>
                              </div>
                              <div>
                                <label class="inline-block cursor-pointer text-gray-600 text-sm">Concepto: <b><%= item.aux_concept %></b></label><br>
                              </div>
                              <div class="flex mb-2">
                                <div class="w-2/6">
                                  <label class="inline-block cursor-pointer text-gray-600 text-sm">Departamento: <b> <%= item.department %></b></label>
                                </div>
                                  <div class="w-2/6 text-right inline-flex">
                                    <div>
                                      <label class="inline-block cursor-pointer text-gray-600 text-sm">Debe: </label>
                                    </div>
                                    <div class="ml-2 w-32">
                                      <label class="inline-block cursor-pointer text-gray-600 text-sm"><b phx-hook="format_number"> <%= item.debit %></b></label>
                                    </div>
                                  </div>
                                  <div class="w-2/6 text-right inline-flex">
                                    <div>
                                      <label class="inline-block cursor-pointer text-gray-600 text-sm">Haber: </label>
                                    </div>
                                    <div class="ml-2 w-32">
                                      <label class="inline-block cursor-pointer text-gray-600 text-sm"> <b phx-hook="format_number"> <%= item.credit %></b></label>
                                    </div>
                                  </div>
                              </div>
                            </div>
                          </div>
                          <!-----------------------------------END INFO--------------------------------->
                          <div class="w-1/6 text-right">
                            <button phx-click="edit_aux" value="<%=item.id%>" phx-target="#one" class="bg-teal-500 text-white text-center hover:bg-teal-400 border rounded">
                              <svg aria-hidden="true" focusable="false" data-prefix="fal" data-icon="edit" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" class="h-6 w-6 m-1"><path fill="currentColor" d="M402.3 344.9l32-32c5-5 13.7-1.5 13.7 5.7V464c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V112c0-26.5 21.5-48 48-48h273.5c7.1 0 10.7 8.6 5.7 13.7l-32 32c-1.5 1.5-3.5 2.3-5.7 2.3H48v352h352V350.5c0-2.1.8-4.1 2.3-5.6zm156.6-201.8L296.3 405.7l-90.4 10c-26.2 2.9-48.5-19.2-45.6-45.6l10-90.4L432.9 17.1c22.9-22.9 59.9-22.9 82.7 0l43.2 43.2c22.9 22.9 22.9 60 .1 82.8zM460.1 174L402 115.9 216.2 301.8l-7.3 65.3 65.3-7.3L460.1 174zm64.8-79.7l-43.2-43.2c-4.1-4.1-10.8-4.1-14.8 0L436 82l58.1 58.1 30.9-30.9c4-4.2 4-10.8-.1-14.9z" class=""></path></svg>
                            </button>
                            <button phx-click="delete_aux" value="<%=item.id%>" phx-target="#one" class="bg-red-500 text-white text-left hover:bg-red-400 border rounded">
                              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="minus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="h-6 w-6 m-1"><path fill="currentColor" d="M416 208H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h384c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z" class=""></path></svg>
                            </button>
                          </div>
                        </div>
                      <% end %>
                      <!---------------------END DIV DE TODA LA INFO------------------------->
                    </div>
                  </div>
                  <!----END DIV OVERFLOW -->

                <div class="block">
                  <div class="inline-flex w-full">
                    <div class="w-1/3 inline-block mr-2 p-3">
                      <div class=" rounded bg-gray-200 w-full py-2 px-4">
                        <label class="block tracking-wide text-gray-700 font-medium" for="in_debe">Debe</label>
                        <label class="text-lg text-right block"><b phx-hook="format_number"><%= @pollys.sum_debe %> </b></label>
                      </div>
                    </div>
                    <div class="w-1/3 inline-block mr-2 p-3">
                      <div class=" rounded bg-gray-200 w-full py-2 px-4">
                        <label class="block tracking-wide text-gray-700 font-medium" for="in_haber">Haber</label>
                        <label class="text-lg text-right block"><b phx-hook="format_number"><%= @pollys.sum_haber %> </b></label>
                      </div>
                    </div>
                    <div class="w-1/3 inline-block mr-2 p-3">
                      <div class=" rounded bg-gray-200 w-full py-2 px-4">
                        <label class="block tracking-wide text-gray-700 font-medium" for="in_debe">Total</label>
                        <label class="text-lg text-right block"><b phx-hook="format_number"><%= @pollys.total %> </b></label>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>  <!-----------------END DIV 2 PART 2------------------------------>
          </div>
      </div>
    </div>
    """
  end
  def mount(socket) do
    dropdowns = []
    policytypes = AccountingSystem.PolicyTipeHandler.get_all_as_list
    changeset = PolicyHandler.change_policy(%PolicySchema{})
    pollys = %{audited: "", concept: "", fiscal_exercise: "", has_documents: "", period: "", policy_date: "", policy_type: "0", aux_concept: "", debit: 0, department: "", credit: 0, id: "", sum_haber: 0, sum_debe: 0, total: 0, focused: 0, account: "", name: "", id_account: "", id_aux: ""}

    {:ok, assign(socket,
      dropdowns: dropdowns,
      arr: [],
      changeset: changeset,
      policytypes: policytypes,
      pollys: pollys,
      policy_edit: %{},
      edit: false,
      update_text: "",
      cancel?: false,
      message_confirm: nil,
      status: false
    )}
  end

  # def preload(attrs) do
  #   case List.first(attrs).update do
  #     true -> fill(List.first(attrs).edit, attrs)
  #     false -> attrs
  #   end
  # end

  def update(params, socket) do
    IO.inspect(params, label: "PARAAAAMS---------------------------------------------------------->")
    cancel? = params.cancel?
    message_confirm = params.message_confirm
    status = params.pollys.status
    #IO.inspect(socket.assigns, label: "SOCKET ASSSSSS---------------------------------------------------------->")
    pollys = params.pollys
    params = socket.assigns |> Map.put(:pollys, pollys) |> Map.put(:arr, params.arr) |> Map.put(:edit, params.edit)
    params = params
    |> Map.put(:pollys,
    case socket.assigns.edit do
      true -> socket.assigns.pollys |> Map.merge(params.pollys)
      false -> params.pollys
    end
    )

    dropdowns = AccountingSystem.AccountHandler.search_detail_account(params.pollys.account)
    {:ok, assign(socket,
      dropdowns: dropdowns,
      pollys: params.pollys,
      arr: params.arr,
      edit: params.edit,
      update_text: params.update_text,
      cancel?: cancel?,
      message_confirm: message_confirm,
      status: status
      )}
  end
end
