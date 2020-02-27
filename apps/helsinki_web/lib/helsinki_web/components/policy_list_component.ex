defmodule AccountingSystemWeb.PolicyListComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.{
    PolicyHandler,
    GenericFunctions
  }

  def mount(socket) do
    {:ok, assign(socket,
    policy_list: PolicyHandler.get_policy_list,
    new?: false,
    edit?: false,
    actionx: "edit",
    pollys: %{audited: "unchecked", concept: "", fiscal_exercise: "", has_documents: "unchecked", period: "", policy_date: "", policy_type: "0", aux_concept: "", debit: 0, department: "", credit: 0, id: "", sum_haber: 0, sum_debe: 0, total: 0, focused: 0, account: "", name: "", id_account: ""},
    arr: [],
    policy_id: 0,
    message: nil
    )}
  end

  def update(attrs, socket) do
      {:ok, assign(socket, id: attrs.id, message: nil)}
  end

  def handle_event("create_policy", params, socket) do
    {:noreply, assign(socket, new?: true, edit?: false, actionx: "edit", message: nil)}
  end

  def handle_event("open_policy", params, socket) do
    id = params["id"] |> String.to_integer()
    {:noreply, assign(socket, new?: false, edit?: true, policy_id: id, message: nil)}
  end

  def handle_event("edit_and_save_this", params, socket) do
    current_policy = params["id"] |> String.to_integer |> PolicyHandler.get_policy!
    {:ok, policy} = PolicyHandler.update_policy(current_policy, params)
    notification()
    {:noreply, assign(socket,
    edit?: false,
    policy_list: PolicyHandler.get_policy_list,
    arr: [],
    policy_id: 0,
    pollys: %{audited: "unchecked", concept: "", fiscal_exercise: "", has_documents: "unchecked", period: "", policy_date: "", policy_type: "0", aux_concept: "", debit: 0, department: "", credit: 0, id: "", sum_haber: 0, sum_debe: 0, total: 0, focused: 0, account: "", name: "", id_account: ""},
    message: "Póliza " <> policy.serial <> "-" <> Integer.to_string(policy.policy_number) <> " actualizada correctamente"
    )}
  end

  def handle_event("delete_policy", params, socket) do
    {:ok, policy} = params["id"] |> AccountingSystem.PolicyHandler.delete_policy_with_aux
    notification()
    {:noreply, assign(socket,
      edit?: false,
      policy_list: PolicyHandler.get_policy_list,
      message: "Póliza " <> policy.serial <> "-" <> Integer.to_string(policy.policy_number) <> " eliminada correctamente"
    )}
  end

  def handle_event("create_new", _params, socket) do
    {:noreply, assign(socket, new?: true, edit?: false, update_text: "", focused: 0, message: nil)}
  end

  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, new?: false, edit?: false, message: nil)}
  end

  def handle_event("show_accounts", params, socket) do
    {:noreply, assign(socket, update_text: params["value"])}
  end

  def handle_event("autocomplete", params, socket) do
    id = params["id"]
    nombre = params["name"]
    cuenta = params["account"]
    pollys = Map.put(socket.assigns.pollys, :focused, 0)
    pollys = pollys
              |> Map.put(:id, id)
              |> Map.put(:name, nombre)
              |> Map.put(:account, cuenta)
              |> Map.put(:id_account, id)
    {:noreply, assign(socket, pollys: pollys, update_text: "")}
  end

  def handle_event("account_focused", _params, socket) do
    pollys = Map.put(socket.assigns.pollys, :focused, 1)
    {:noreply, assign(socket, pollys: pollys)}
  end

  def handle_event("update_form", params, socket) do
    IO.inspect(params, label: "PAAAAAAAAAAAAAAAAAARAAAAAAMSSSSS TARGEEEETTTT:::::>>>")

    params = check(params, params)
    pollys = Map.merge(socket.assigns.pollys, GenericFunctions.string_map_to_atom(params))
    {:noreply, assign(socket, pollys: pollys)}
  end

  def handle_event("action_account", params, socket) do
    case PolicyHandler.save_policy(params, socket.assigns.arr) do
      {:ok, policy} ->
        notification()
        {:noreply, assign(socket,
        new?: false,
        edit?: false,
        policy_list: PolicyHandler.get_policy_list,
        pollys: %{audited: "unchecked", concept: "", fiscal_exercise: "", has_documents: "unchecked", period: "", policy_date: "", policy_type: "0", aux_concept: "", debit: 0, department: "", credit: 0, id: "", sum_haber: 0, sum_debe: 0, total: 0, focused: 0, account: "", name: "", id_account: ""},
        arr: [],
        policy_id: 0,
        message: "Póliza guardada con éxito: " <>policy.serial <> "-" <> Integer.to_string(policy.policy_number)
        )}
      {:error, _} ->
        {:noreply, socket |> put_flash(:error, "NO SE PUDO GUARDAR")}
    end
  end

  defp notification() do
    Task.async(fn ->
      :timer.sleep(5500)
      %{message: "close"}
    end)
    :ok
  end

  def handle_event("save_aux", params, socket) do
    case AccountingSystem.AuxiliaryHandler.validate_auxiliar(params) do
      {:ok, _} ->
        totals(params, socket)
      {:error, _} ->
        {:noreply, socket}
    end
  end

  defp totals(params, socket) do
    params = GenericFunctions.string_map_to_atom(params)
    sumh = socket.assigns.pollys.sum_haber
    sumd = socket.assigns.pollys.sum_debe
    sumhe = sumh + void(params.credit)
    sumde = sumd + void(params.debit)
    sumtot = sumhe - sumde
    clean = %{account: "", aux_concept: "", credit: "0", debit: "0", department: "", id_account: "", name: ""}
    pollys = socket.assigns.pollys
      |> Map.put(:sum_haber, sumhe |> Float.round(2))
      |> Map.put(:sum_debe, sumde |> Float.round(2))
      |> Map.put(:total, sumtot |> Float.round(2))
      |> Map.merge(clean)
    {:noreply, assign(socket, arr: socket.assigns.arr ++ [params |> Map.put(:id, length(socket.assigns.arr))], pollys: pollys)}
  end

  defp void(some) do
    case some do
      0 -> 0.0
      _ -> some
            |> Float.parse
            |> Tuple.to_list
            |> List.first
    end
  end

  def check(params, %{"_target" => ["audited"]}) do
    if(params["audited"] == "unchecked", do: params |> Map.put("audited", "checked"), else: params |> Map.put("audited", "unchecked"))
  end

  def check(params, %{"_target" => ["has_documents"]}) do
    if(params["has_documents"] == "unchecked" , do: params |> Map.put("has_documents", "checked"), else: params |> Map.put("has_documents", "unchecked"))
  end

  def check(params, _) do
    params
  end

  def render(assigns) do
    ~L"""
    <%= if @message do %>
      <%= live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "notification", message: @message, show: true) %>
      <% end %>
    <div id="one" class="bg-white h-hoch-93 w-80 mt-16 ml-16 block float-left">
    <div class="relative w-full px-2 mt-4">
      <input class="focus:outline-none focus:bg-white focus:border-blue-500 h-8 w-full rounded border bg-gray-300 pl-2" placeholder="Buscar Póliza" >
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
      <button phx-click="create_new" phx-value-id="xxx" phx-target="#one" class="py-2 bg-teal-500 hover:bg-teal-400 text-white items-center inline-flex font-bold rounded text-sm w-full ">
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
      <%= for item <- @policy_list do %>
        <div class="w-full px-2 block">
          <div phx-click="open_policy" phx-value-id="<%= item.id %>" phx-target="#one" class="border cursor-pointer w-full block bg-gray-200 p-3 mt-2 rounded relative hover:bg-gray-300">
            <h2 class="text-gray-700 text-xl"><%= item.serial  %>-<%= item.policy_number %></h2>
            <label class="inline-block cursor-pointer text-gray-600 font-bold text-sm">Concepto: <b><%= item.concept %></b></label></br>
            <label class="inline-block cursor-pointer text-gray-600 font-bold text-sm">Tipo: <b><%= item.type_description %></b></label>
          </div>
        </div>

      <% end %>
    </div>
    </div>

    <%= if @new? do %>
      <%= live_component(@socket, AccountingSystemWeb.NewPolicyComponent, id: 0, update_text: @update_text, pollys: @pollys, arr: @arr, edit: false) %>
    <% end %>

    <%= if @edit? do %>
      <%= live_component(@socket, AccountingSystemWeb.NewPolicyComponent, id: @policy_id, update_text: "", pollys: %{}, arr: [], edit: @edit?) %>
    <% end %>
    """
  end
end
