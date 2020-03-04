defmodule AccountingSystemWeb.AccountsComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AccountingSystem.AccountHandler, as: Account

  def render(assigns) do
    ~L"""
    <%= if @error do %>
        <%=live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "error_comp", message: @error, show: true, change: @change, notification_type: "error") %>
      <% end %>
      <div id="one" class="bg-white h-hoch-93 w-80 mt-16 ml-16 block float-left">
      <div class="w-full py-2 bg-blue-700">
        <p class="ml-2 font-bold text-lg text-white">Cuentas</p>
      </div>
        <div class="relative w-full px-2 mt-4">
        <input class="focus:outline-none focus:bg-white focus:border-blue-500 h-8 w-full rounded border bg-gray-300 pl-2" placeholder="Buscar Cuenta" phx-keyup="search_account" phx-target="#one">
          <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
            class="absolute right-0 top-0 h-4 w-4 mr-4 mt-2">
            <g>
              <path fill="currentColor" d="M208 80a128 128 0 1 1-90.51 37.49A127.15 127.15 0 0 1 208 80m0-80C93.12 0 0 93.12 0 208s93.12 208 208 208 208-93.12 208-208S322.88 0 208 0z"
              class="text-gray-600">
              </path>
              <path fill="currentColor" d="M504.9 476.7L476.6 505a23.9 23.9 0 0 1-33.9 0L343 405.3a24 24 0 0 1-7-17V372l36-36h16.3a24 24 0 0 1 17 7l99.7 99.7a24.11 24.11 0 0 1-.1 34z"
              class="text-gray-500">
              </path>
            </g>
          </svg>
        </div>

        <div class="w-1/2 px-2 mt-2">
          <button phx-click="create_new" phx-value-level="0" phx-target="#one" class="py-2 bg-teal-500 text-white hover:bg-teal-400 items-center inline-flex font-bold rounded text-sm w-full ">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
              class="h-4 w-4 mr-2 ml-auto">
              <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"
              class="text-white">
              </path>
            </svg>
            <label class="cursor-pointer mr-auto text-white">Nueva</label>
          </button>
        </div>

        <div class="h-hoch-75 overflow-y-scroll pb-16 mt-2">
          <%= for item <- @accounts do %>
            <div class="w-full px-2 block">
              <div phx-click="open_child" phx-value-id="<%= item.id %>" phx-value-level="0" phx-value-origin="true" phx-target="#one" class="border cursor-pointer w-full block bg-gray-200 p-3 mt-2 rounded relative hover:bg-gray-300">
                <h2 class="tooltip text-gray-800 text-xl block"><%= if String.length(item.name) > 38, do: String.slice(item.name, 0, 38) <> "...", else: item.name %>
                  <%= if String.length(item.name) > 38 do %>
                    <span class='tooltip-text text-sm text-white bg-blue-500 mt-8 -ml-20 mr-1 rounded'><%= item.name %></span>
                  <% end %>
                </h2>
                <label class="tooltip cursor-pointer text-gray-600 font-bold text-sm block">Código: <b><%= String.slice(item.code, 0, 70) %></b>
                <%= if String.length(item.code) > 70 do %>
                  <span class='tooltip-text text-sm text-white bg-blue-500 mt-8 -ml-56 mr-1 rounded'><%= item.code %></span>
                <% end %>
                </label>
                <div class="block relative">
                  <label class="cursor-pointer text-gray-600 font-bold text-sm">
                    Tipo: <b><%= if item.type == "A", do: "Acumulativo", else: "Detalle" %></b>
                  </label>
                  <div class="absolute bg-<%= if item.status == "A", do: "green", else: "red" %>-200 px-3 text-sm font-bold top-0  right-0 rounded-full text-<%= if item.status == "A", do: "green", else: "red" %>-700  ">
                    <%= if item.status == "A", do: "Activo", else: "Inactivo" %>
                  </div>
                </div>
              </div>
            </div>
          <% end %>
        </div>



      </div>

      <%= for component <- @child_components do %>
        <%= live_component(@socket, AccountingSystemWeb.SubAccountsComponent, subaccounts: component.subaccounts, father_name: component.name, next_level: (component.level + 1), id: component.id, code: component.code, type: component.type, description: component.description, status_father: component.status) %>
      <% end %>

      <%= if @new? do %>
        <%= live_component(@socket, AccountingSystemWeb.FormAccountComponent, level: @level_form_account + 1, id: @idx, edit: @edit?, parent_edit: %{}, bendiciones?: false) %>
      <% end %>

      <%= if @edit? do %>
        <%= live_component(@socket, AccountingSystemWeb.FormAccountComponent, level: @level_form_account + 1, id: @idx, edit: @edit?, parent_edit: @parent_editx, bendiciones?: @bendiciones ) %>
      <% end %>
    """
  end
  def mount(socket) do
    {:ok, assign(socket,
    accounts: get_accounts_t(-1, -1),
    child_components: [],
    actually_level: 0,
    level_form_account: 0,
    new?: false,
    idx: 0,
    edit?: false,
    parent_editx: %{},
    bendiciones: false,
    error: nil,
    change: false,
    notification_type: "error"
    )}
  end

  def update(attrs, socket) do
    attrs |> IO.inspect(label: " Attrs in Update Account Component -> ")
      {:ok, assign(socket, id: attrs.id)}
  end

  def handle_event("open_child", params, socket) do
    level = params["level"] |> String.to_integer
    id = params["id"] |> String.to_integer
    map_accounts = params["id"]
      |> String.to_integer
      |> get_account_by_id()
    parent_edit = map_accounts
    map_accounts = map_accounts
      |> Map.put(:subaccounts, get_accounts_t(map_accounts.level, map_accounts.id))

    IO.inspect(params["origin"], label: "origin --> ")
    IO.inspect(socket.assigns.child_components, label: "child_components --> ")
    IO.inspect(map_accounts, label: "map_accounts --> ")
    IO.inspect( level, label: "level --> ")

    arr = get_childs(params["origin"] |> to_bool(),
      socket.assigns.child_components,
      map_accounts,
      level) |> IO.inspect(label: "  -> _> >_> > ARR ")

    {:noreply, assign(socket,
      child_components: arr,
      new?: false,
      actually_level: level,
      idx: id,
      parent_editx: parent_edit,
      bendiciones: (if map_accounts.subaccounts != nil, do: (if length(map_accounts.subaccounts) > 0, do: true), else: false)
      )}
  end

  def handle_event("create_new", params, socket) do
    level = (params["level"] |> String.to_integer) - 1
    socket.assigns.child_components
      |> Enum.find(fn acc -> acc.level == level end)
      |> IO.inspect(label: "find?   -> ")
      |> case do
        nil -> {:noreply, assign(socket, new?: true, child_components: [], level_form_account: level, edit?: false)}
        acc -> {:noreply, assign(socket,
          new?: true,
          child_components: get_childs(false, socket.assigns.child_components, acc, level), level_form_account: level, edit?: false, idx: (params["id"] |> String.to_integer))}
      end
  end

  def handle_event("edit_this", params, socket) do
    level = (params["level"] |> String.to_integer) - 1
    socket.assigns.child_components
      |> Enum.find(fn acc -> acc.level == level end)

      |> case do
        nil -> {:noreply, assign(socket, child_components: [], level_form_account: level, edit?: true, new?: false, parent_editx: params["id"] |> String.to_integer |> get_account_by_id())}
        acc -> {:noreply, assign(socket, child_components: get_childs(false, socket.assigns.child_components, acc, level), level_form_account: level, edit?: true, new?: false, parent_editx: params["id"] |> String.to_integer |> get_account_by_id())}
      end

  end

  def error_message(message, socket) do
    Task.async(fn ->
      :timer.sleep(5500)

      assign(socket, error: nil)
      %{error: "close_error"}
    end)
    {:noreply, assign(socket, error: message, change: !socket.assigns.change)}
  end

  def handle_event("action_account", params, socket) do
    rfc = params["rfc_literals"] <> params["rfc_numeric"] <> params["rfc_key"]

    if String.trim(rfc) == "" or AccountingSystem.AccountHandler.validation(rfc) do
      id = params["id"] |> String.to_integer
      level = params["level"] |> String.to_integer
      action = params["action"]
      if action == "edit", do: edit(id, params, socket), else: save_new(params, socket)

      child_index = socket.assigns.child_components
      |> Enum.find_index(fn chil -> chil.id == id end)
      |> set_child_index()

      daddy = socket.assigns.child_components
      |> Enum.at(child_index - 1)

      child_components = socket.assigns.child_components
        |> Enum.map(fn child -> update_family(child, daddy, id, level) end)

      {:noreply, assign(socket,
        child_components: child_components,
        edit?: false,
        new?: false,
        accounts: get_accounts_t(-1, -1)
        )}
    else
      error_message("RFC Inválido", socket)
    end
  end

  def handle_event("delete_account", params, socket) do
    case Account.delete_account(get_account_by_id(params["id"])) do
    {:ok, _account} ->
      {:noreply, assign(socket, accounts: get_accounts_t(-1, -1), edit?: false, new?: false)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, new?: false, edit?: false)}
  end

  def handle_event("search_account", %{"value" => text}, socket) do
    result = Account.get_from_strings(text)
    {:noreply, assign(socket, accounts: result)}
  end

  defp set_child_index(index) do
    if is_nil(index), do: 0, else: index
  end

  def edit(id, params, socket) do
    account = get_account_by_id(id)
    params = load_params(params)
    |> Map.put("parent_account", account.parent_account)
    |> Map.put("level", Integer.to_string(account.level))
    |> Map.put("root_account", account.root_account)
    |> Map.put("apply_to", (params["apply_to"] |> String.to_integer))
    |> Map.put("group_code", (params["group_code"] |> String.to_integer))
    |> Map.put("third_party_prosecutor", (params["third_party_prosecutor"] |> String.to_integer))

    case Account.update_account(account, params) do
      {:ok, _account} ->
        {:noreply, socket |> put_flash(:info, "Actualizado")}

        {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
    {:noreply, socket}
  end

  def save_new( params, socket) do
    params = load_params(params)
    params = AccountingSystem.CodeFormatter.concat_names(params)
    case Account.create_account(params) do
      {:ok, _account} ->
        {:noreply, socket |> put_flash(:info, "Cuenta creada")
        }
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp load_params(params) do
    params
    |> exist_add("is_departamental")
    |> exist_add("character")
    |> exist_add("payment_method")
    |> exist_add("third_party_op")
    |> exist_status_add("status")
  end

  defp exist_add(map, labelx), do: if map[labelx] == "on", do: map |> Map.put(labelx, true), else: map |> Map.put(labelx, false)

  defp exist_status_add(map, labelx), do: if map[labelx] == nil, do: map |> Map.put(labelx, "I"), else: map |> Map.put(labelx, "A")

  defp get_accounts_t(level, parent_account), do: Account.list_of_childs(level, parent_account)

  defp get_account_by_id(id), do: id |> Account.get_account!()

  defp update_family(child, daddy, id, level) do
    cond do
      child.id == id -> get_account_by_id(id)
        |> Map.put(:subaccounts, get_accounts_t((level - 1), id))
      child.id == daddy.id -> get_account_by_id(daddy.id)
        |> Map.put(:subaccounts, get_accounts_t((daddy.level), daddy.id))
      true -> child
    end
  end

  defp get_childs(true, _others, accounts, _level), do: [accounts]
  defp get_childs(false, others, accounts, level) do
    IO.inspect(level, label: "level to find -> ")
    (others
    |> Enum.find(fn child -> child.level == level end)
    |> IO.inspect(label: "find ?    ----> ")
    |> case do
      nil -> others
      _child -> others |> clear_level([], level)
    end) ++ [accounts]
  end

  defp to_bool(text), do: text == "true"

  defp clear_level([account | others], new_arr, level) do
    new_arr = case account.level >= level do
      true -> new_arr
      false -> new_arr ++ [account]
    end
    clear_level(others, new_arr, level)
  end

  defp clear_level([], new_arr, _level), do: new_arr |> IO.inspect(label: "new_arr -> ") |> (Enum.sort_by & &1.level)


end
