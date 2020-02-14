defmodule AccountingSystemWeb.AccountsComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias AccountingSystem.AccountHandler

  def render(assigns) do
    ~L"""
      <div id="one" class="bg-white h-hoch-93 w-80 mt-16 ml-16 block float-left">
        <div class="relative w-full px-2 mt-4">
          <input class="focus:outline-none focus:bg-white focus:border-blue-500 h-8 w-full rounded border bg-gray-300 pl-2" placeholder="Buscar Cuenta" >
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

        <div class="h-hoch-80 overflow-y-scroll pb-16">
          <%= for item <- @accounts do %>
            <div class="w-full px-2 block">
              <div phx-click="open_child" phx-value-id="<%= item.id %>" phx-value-level="0" phx-value-origin="true" phx-target="#one" class="border cursor-pointer w-full block bg-gray-200 p-3 mt-2 rounded relative hover:bg-gray-300">
                <h2 class="pt-4 text-gray-800 text-xl"><%= item.name %></h2>
                <label class="cursor-pointer text-gray-500 font-bold text-sm"><%= item.code %></label>
                <br>
                <label class="cursor-pointer text-gray-500 font-bold text-sm"><%= if item.type == "A", do: "Acumulativo", else: "Detalle" %></label>
                <div class="absolute bg-<%= if item.status == "A", do: "green", else: "red" %>-200 px-3 text-sm font-bold top-0 right-0 rounded-full text-<%= if item.status == "A", do: "green", else: "red" %>-700 mt-2 mr-2">
                <%= if item.status == "A", do: "Activo", else: "Inactivo" %>
                </div>
              </div>
            </div>
          <% end %>
        </div>



      </div>

      <%= for component <- @child_components do %>
        <%= live_component(@socket, AccountingSystemWeb.SubAccountsComponent, subaccounts: component.subaccounts, father_name: component.name, next_level: (component.level + 1), id: component.id, code: component.code, type: component.type, description: component.description) %>
      <% end %>

      <%= if @new? do %>
        <%= live_component(@socket, AccountingSystemWeb.FormAccountComponent, level: @level_form_account + 1, id: @idx ) %>
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
    idx: 0)}
  end

  def update(attrs, socket) do
      {:ok, assign(socket, id: attrs.id)}
  end

  def handle_event("open_child", params, socket) do
    level = params["level"] |> String.to_integer
    id = params["id"] |> String.to_integer
    map_accounts = params["id"]
      |> String.to_integer
      |> get_account()
    map_accounts = map_accounts
      |> Map.put(:subaccounts, get_accounts_t(map_accounts.level, map_accounts.id))
    arr = get_childs(params["origin"] |> to_bool(),
      socket.assigns.child_components,
      map_accounts,
      level)

    {:noreply, assign(socket,
      child_components: arr |> IO.inspect(label: "arr -> "),
      new?: false,
      actually_level: level,
      idx: id)}
  end

  def handle_event("create_new", params, socket) do
    level = (params["level"] |> String.to_integer) - 1
    socket.assigns.child_components
      |> Enum.find(fn acc -> acc.level == level end)
      |> IO.inspect(label: "find?   -> ")
      |> case do
        nil -> {:noreply, assign(socket, new?: true, child_components: [], level_form_account: level)}
        acc -> {:noreply, assign(socket,
          new?: true,
          child_components: get_childs(false, socket.assigns.child_components, acc, level), level_form_account: level)}
      end
  end

  def handle_event("save_new", params, socket) do
    params = exist_add(params, "is_departamental")
    params = exist_add(params, "character")
    params = exist_add(params, "payment_method")
    params = exist_add(params, "third_party_op")
    params = exist_status_add(params, "status")
    IO.inspect(params, label: " -> -> PARAMS -> -> ")
    params = AccountingSystem.CodeFormatter.concat_names(params)
    case AccountingSystem.AccountHandler.create_account(params) do
      {:ok, _account} ->
        {:noreply,
          socket
          |> put_flash(:info, "Cuenta creada")
        }
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp exist_add(map, labelx) do
    if map[labelx] == "on" do
      map |> Map.put(labelx, true)
    else
      map |> Map.put(labelx, false)
    end
  end

  defp exist_status_add(map, labelx) do
    if map[labelx] == nil, do: map |> Map.put(labelx, "I"), else: map |> Map.put(labelx, "A")
  end

  defp get_accounts_t(level, parent_account) do
    AccountHandler.list_of_childs(level, parent_account)
  end

  defp get_account(id), do: id |> AccountHandler.get_account!()

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
