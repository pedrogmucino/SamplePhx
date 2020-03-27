defmodule AccountingSystemWeb.PolicyListComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  alias AccountingSystem.AuxiliaryHandler, as: Auxiliar
  alias AccountingSystem.CodeFormatter, as: Formatter
  alias AccountingSystem.XlsxFunctions, as: Xlsx
  alias AccountingSystem.AccountHandler, as: Account
  alias AccountingSystem.GenericFunctions, as: Generic
  alias AccountingSystemWeb.Alexandria
  alias AccountingSystem.{
    PolicyHandler,
    EctoUtil
  }
  alias AccountingSystemWeb.NotificationComponent

  def mount(socket) do
    label_todos = add_todos(AccountingSystem.PolicyTipeHandler.list_policytypes)
    {:ok, assign(socket,
    policy_list: PolicyHandler.get_policy_list,
    new?: false,
    edit?: false,
    actionx: "edit",
    pollys: %{audited: "unchecked", concept: "", fiscal_exercise: "", has_documents: "unchecked", period: "", policy_date: "", policy_type: "0", aux_concept: "", debit: 0, department: "", credit: 0, id: "0", sum_haber: 0, sum_debe: 0, total: 0, focused: 0, account: "", name: "", id_account: "", id_aux: ""},
    arr: [],
    policy_id: 0,
    message: nil,
    message_confirm: nil,
    update: false,
    update_text: "",
    cancel?: false,
    policytypes: label_todos,
    type_id_selected: 0,
    dropdowns: [],
    error: nil,
    change: false,
    xml_name: Generic.to_string_empty,
    add_xml?: false,
    xml_b64: Generic.to_string_empty,
    req_xml: false,
    non_filtered: [],
    filter_activated: false
    )}
  end

  def update(attrs, socket) do
    attrs |> Generic.to_inspect(" --> Update in list ------------------------------> ")
    {:ok, assign(socket, id: attrs.id, message: nil, error: nil, xml_name: attrs.name, add_xml?: (if attrs.name != "", do: false), xml_b64: attrs.xml_b64)}
  end

  def add_todos(types) do
    todos = %AccountingSystem.PolicyTypeSchema{
      id: 0,
      name: "Todos"
    }
    List.flatten(types, [todos])
    |> (Enum.sort_by & &1.id)
  end

  def handle_event("open_policy", params, socket) do
    all_info = fill(params)
    id = params["id"] |> String.to_integer()
    {:noreply, assign(socket, new?: false, edit?: true, policy_id: id, message: nil, update: true, arr: all_info.arr, dropdowns: all_info.dropdowns, id: all_info.id, pollys: all_info.pollys, update_text: all_info.update_text)}
  end

  def handle_event("edit_and_save_this", params, socket) do
    current_policy = params["id"] |> String.to_integer |> PolicyHandler.get_policy!
    save_auxiliaries(socket.assigns.pollys.policy_number, params["id"] |> String.to_integer, socket.assigns.arr)
    params = params
              |> Map.put("audited", checked(params["audited"]))
              |> Map.put("has_documents", checked(params["has_documents"]))
    {:ok, policy} = PolicyHandler.update_policy(current_policy, params)
    NotificationComponent.set_timer_notification()
    {:noreply, assign(socket,
    edit?: false,
    policy_list: PolicyHandler.get_policy_list,
    arr: [],
    policy_id: 0,
    pollys: %{audited: "unchecked", concept: "", fiscal_exercise: "", has_documents: "unchecked", period: "", policy_date: "", policy_type: "0", aux_concept: "", debit: 0, department: "", credit: 0, id: "", sum_haber: 0, sum_debe: 0, total: 0, focused: 0, account: "", name: "", id_account: ""},
    message: "Póliza " <> policy.serial <> "-" <> Integer.to_string(policy.policy_number) <> " actualizada correctamente",
    xml_name: Generic.to_string_empty
    )}
  end

  def handle_event("delete_policy", params, socket) do
    policy = params["id"] |> String.to_integer |> PolicyHandler.get_policy!
    {:noreply, assign(socket,
      cancel?: true,
      message_confirm: "¿Desea cancelar la póliza " <> policy.serial <> "-" <> Integer.to_string(policy.policy_number) <> "?"
    )}
  end

  def handle_event("si_", _params, socket) do
    case PolicyHandler.cancel_policy(socket.assigns.id |> String.to_integer) do
      {:ok, policy} ->
        case AccountingSystem.AuxiliaryHandler.cancel_auxiliary(policy.id) do
          {:error, %Ecto.Changeset{} = changeset} ->
            NotificationComponent.set_timer_notification_error()
            {:noreply, assign(socket,
            cancel?: false,
            new?: false,
            edit?: false,
            policy_list: PolicyHandler.get_policy_list,
            error: "Error al intentar cancelar las partidas de la póliza. " <> EctoUtil.get_errors(changeset),
            message: nil,
            change: !socket.assigns.change)
            }
             _ ->
            NotificationComponent.set_timer_notification()
            {:noreply, assign(socket,
            cancel?: false,
            new?: false,
            edit?: false,
            policy_list: PolicyHandler.get_policy_list,
            message: "Póliza cancelada correctamente.")
          }
        end
      {:error, %Ecto.Changeset{} = changeset} ->
        NotificationComponent.set_timer_notification_error()
        {:noreply, assign(socket,
        cancel?: false,
        new?: false,
        edit?: false,
        policy_list: PolicyHandler.get_policy_list,
        error: "Error al intentar cancelar la póliza. " <> EctoUtil.get_errors(changeset),
        message: nil,
        change: !socket.assigns.change)
        }
    end
  end

  def handle_event("no_", _params, socket) do
    {:noreply, assign(socket, cancel?: false)}
  end

  def handle_event("create_new", _params, socket) do
    now = Date.utc_today
    today = "#{now.year}-#{Formatter.add_zero(Integer.to_string(now.month), 2)}-#{Formatter.add_zero(Integer.to_string(now.day), 2)}"
    {:noreply, assign(socket,
    policy_list: PolicyHandler.get_policy_list,
    new?: true,
    edit?: false,
    actionx: "new",
    pollys: %{audited: "unchecked", concept: "", fiscal_exercise: now.year, has_documents: "unchecked", period: now.month, policy_date: today, policy_type: "0", aux_concept: "", debit: 0, department: "", credit: 0, id: "0", sum_haber: 0, sum_debe: 0, total: 0, focused: 0, account: "", name: "", id_account: "", id_aux: "", status: true, xml_name: Generic.to_string_empty, xml_b64: Generic.to_string_empty, req_xml: false},
    arr: [],
    policy_id: 0,
    message: nil,
    update: false,
    update_text: "",
    cancel?: false,
    message_confirm: nil,
    type_id_selected: 0,
    status: true,
    id: 0,
    dropdowns: []
    )}
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
    requiere_xml = params["req_xml"]
    pollys = Map.put(socket.assigns.pollys, :focused, 0)
    pollys = pollys
              |> Map.put(:name, nombre)
              |> Map.put(:account, cuenta)
              |> Map.put(:id_account, id)
              |> Map.put(:req_xml, requiere_xml)
    {:noreply, assign(socket, pollys: pollys, update_text: "", dropdowns: [])}
  end

  def handle_event("account_focused", _params, socket) do
    case AccountingSystem.AccountHandler.search_detail_account(socket.assigns.pollys.account) do
      [] ->
        AccountingSystemWeb.NotificationComponent.set_timer_notification_error()
        {:noreply, assign(socket, dropdowns: [], error: "No existen cuentas de detalle", change: !socket.assigns.change)}
        dropdowns ->
          IO.puts("LA WEA Dropdowns")
        {:noreply, assign(socket, dropdowns: dropdowns)}
    end
  end

  def handle_event("update_form", params, socket) do
    params = check(params, params)
    params = debit_credit_values(params, params)
    dropdowns = search_account(params["account"], params)
    pollys = Map.merge(socket.assigns.pollys, Generic.string_map_to_atom(params))
    {:noreply, assign(socket, pollys: pollys, update: false, arr: socket.assigns.arr, dropdowns: dropdowns)}
  end

  def handle_event("action_account", params, socket) do
    case PolicyHandler.save_policy(params, socket.assigns.arr) do
      {:ok, policy} ->
        NotificationComponent.set_timer_notification()
        {:noreply, assign(socket,
        new?: false,
        edit?: false,
        policy_list: PolicyHandler.get_policy_list,
        pollys: %{audited: "unchecked", concept: "", fiscal_exercise: "", has_documents: "unchecked", period: "", policy_date: "", policy_type: "0", aux_concept: "", debit: 0, department: "", credit: 0, id: "", sum_haber: 0, sum_debe: 0, total: 0, focused: 0, account: "", name: "", id_account: "", id_aux: ""},
        arr: [],
        policy_id: 0,
        message: "Póliza guardada con éxito: " <>policy.serial <> "-" <> Integer.to_string(policy.policy_number)
        )}
      {:error, %Ecto.Changeset{} = changeset} ->
        NotificationComponent.set_timer_notification_error()
        {:noreply, assign(socket,
          changeset: changeset,
          error: "No pudo registrarse la póliza. Validar lo siguiente:<br>" <> EctoUtil.get_errors(changeset),
          change: !socket.assigns.change
        )}
    end
  end

  def handle_event("save_aux", params, socket) do
    if !socket.assigns.add_xml? do
      case AccountingSystem.AuxiliaryHandler.validate_auxiliar(params) do
      {:ok, _} ->
        totals(params["id_aux"], params, socket)
      {:error, _} ->
        {:noreply, socket}
      end
    else
      {:noreply, socket}
    end
  end

  def handle_event("add_xml_file", _params, socket) do
    {:noreply, assign(socket, add_xml?: true)}
  end

  def handle_event("delete_aux", %{"value" => id}, socket) do
    sum_debe = socket.assigns.pollys.sum_debe - to_float(Enum.find(socket.assigns.arr, fn aux -> aux.id == String.to_integer(id) end).debit)
    sum_haber = socket.assigns.pollys.sum_haber - to_float(Enum.find(socket.assigns.arr, fn aux -> aux.id == String.to_integer(id) end).credit)
    total = sum_haber - sum_debe
    clean = %{account: "", aux_concept: socket.assigns.pollys.concept, credit: "0", debit: "0", department: "", id_account: "", name: "", id_aux: ""}
    new_polly = Map.merge(socket.assigns.pollys, %{sum_debe: sum_debe, sum_haber: sum_haber, total: total})
                  |> Map.merge(clean)
    new_list = socket.assigns.arr
                |> Enum.filter(fn aux -> aux.id != String.to_integer(id) end)
    {:noreply, assign(socket, arr: new_list, pollys: new_polly)}
  end

  def handle_event("focused_concept", _params, socket) do
    pollys = socket.assigns.pollys
    pollys = pollys
              |> Map.put(:aux_concept, pollys.concept)
    {:noreply, assign(socket, pollys: pollys)}
  end

  def handle_event("edit_aux", %{"value" => id}, socket) do
    actual = socket.assigns.arr |> Enum.find(fn elto -> elto.id == id |> String.to_integer end)
    x_name = if actual |> Map.get(:xml_name) == nil, do: "", else: actual.xml_name
    map = Map.new()
            |> Map.put(:id_account, actual.id_account)
            |> Map.put(:account, actual.account)
            |> Map.put(:name, AccountingSystem.AccountHandler.get_description_by_id(actual.id_account))
            |> Map.put(:aux_concept, actual.aux_concept)
            |> Map.put(:department, actual.department)
            |> Map.put(:debit, actual.debit)
            |> Map.put(:credit, actual.credit)
            |> Map.put(:id_aux, actual.id)
            |> Map.put(:xml_name, x_name)
    {:noreply, assign(socket, pollys: Map.merge(socket.assigns.pollys, map), update: false)}
  end

  def handle_event("type_selected", params, socket) do
    type_id = params["policy_type_selected"] |> String.to_integer
    all_policy = PolicyHandler.get_policy_list

    {:noreply, assign(socket,
      type_id_selected: type_id,
      filter_activated: false,
      policy_list: (if type_id == 0, do: all_policy, else: Enum.filter(all_policy, fn x -> x.policy_type == type_id end)),
      non_filtered: (if type_id == 0, do: all_policy, else: Enum.filter(all_policy, fn x -> x.policy_type == type_id end))
    )}
  end

  def handle_event("date_fill", %{"value" => ""}, socket) do
    new_pollys = socket.assigns.pollys
      |> Map.put(:fiscal_exercise, "")
      |> Map.put(:period, "")
    {:noreply, assign(socket, pollys: new_pollys)}
  end

  def handle_event("date_fill", %{"value" => date}, socket) do
    date = String.split(date, "-")
    new_pollys = socket.assigns.pollys
      |> Map.put(:fiscal_exercise, Enum.at(date, 0))
      |> Map.put(:period, String.to_integer(Enum.at(date, 1)))
    {:noreply, assign(socket, pollys: new_pollys)}
  end

  def handle_event("load_aux", %{"_target" => []}, socket) do
    {:noreply, socket}
  end

  def handle_event("load_aux", %{"value" => path, "name" => name}, socket) do
    data = Xlsx.get_data(path, name)
            |> validate_header
            |> validate_accounts
            |> validate_concept
            |> validate_debit_credit
            |> complete_aux_data
            |> calculate_totals
            |> error_or_pass(socket)
  end

  def handle_event("set_series", _params, socket) do
    Xlsx.create_template("template.xlsx")
    #Phoenix.Controller.send_download(socket.conn, {:file, "template.xlsx"})
    {:noreply, socket}
  end

  defp validate_header(exel_data) do
    exel_data
      |> List.first
      |> validate_length
      |> List.myers_difference(Xlsx.get_header)
      |> more_than_eq(exel_data)
  end

  def handle_event("pending", params, socket) do
    if socket.assigns.filter_activated do
      {:noreply, assign(socket, change: !socket.assigns.change, filter_activated: false, message: nil, error: nil, policy_list: socket.assigns.non_filtered)}
    else
      {:noreply, assign(socket, change: !socket.assigns.change, filter_activated: true, message: nil, error: nil, non_filtered: socket.assigns.policy_list, policy_list: Enum.filter(socket.assigns.policy_list, fn x -> x.pending_xml end))}
    end
  end

  defp validate_accounts({:error, data}), do: {:error, data}
  defp validate_accounts({:ok, data}) do
    db_accounts = Account.get_all_detail_accounts
    data
      |> Enum.filter(fn row -> not(exist_account_in(row, db_accounts)) end)
      |> nonexisting_accounts(data)
      |> fill_ids(db_accounts)
  end

  defp validate_concept({:error, message}), do: {:error, message}
  defp validate_concept({:ok, data}) do
    data
      |> Enum.filter(fn x -> Enum.at(x, 1) == nil end)
      |> nonexisting_concept(data)
  end

  defp validate_debit_credit({:error, message}), do: {:error, message}
  defp validate_debit_credit({:ok, data}) do
    data
      |> Enum.reject(fn aux -> just_one_value(Enum.at(aux, 3), Enum.at(aux, 4)) end)
      |> evaluate_debit_credit(data)
  end

  defp complete_aux_data({:error, message}), do: {:error, message}
  defp complete_aux_data({:ok, data}) do
    {:ok,
      data
        |> Enum.map(fn x -> create_map(x) end)
        |> Stream.with_index(1)
        |> Enum.to_list
        |> Enum.map(fn x -> add_id_number(x) end )
    }
  end
  defp calculate_totals({:error, message}), do: {:error, message}
  defp calculate_totals({:ok, data}) do
    sh = Enum.reduce(data, 0.0, fn x, acc -> x.credit + acc end)
    sd = Enum.reduce(data, 0.0, fn x, acc -> x.debit + acc end)
    %{pollys: Map.new()
                |> Map.put(:sum_haber, Float.round(sh, 2))
                |> Map.put(:sum_debe, Float.round(sd, 2))
                |> Map.put(:total, Float.round(sh-sd, 2)),
      arr: data}
  end
#********************************VALIDATE HEADER**********************************
  defp validate_length(data), do: is_five(Enum.count(data), data)
  defp is_five(5, data), do: data
  defp is_five(_, _), do: []
  defp more_than_eq([del: _], _), do: {:error, "Error de encabezado, favor de revisar el orden y que no contenga más información fuera de la tabla"}
  defp more_than_eq([ins: _], _), do: {:error, "Error de encabezado, favor de revisar el orden y que no contenga más información fuera de la tabla"}
  defp more_than_eq(_, data), do: {:ok, delete_header(List.pop_at(data, 0))}
  defp delete_header({_, data}), do: data

#********************************VALIDATE ACCOUNTS********************************
  defp exist_account_in(row, data), do: Enum.any?(data, fn x -> Enum.at(x, 1) == List.first(row) end)
  defp nonexisting_accounts([], data), do: {:ok, data}
  defp nonexisting_accounts(error, _), do: {:error, "Las Cuentas #{List.to_string(Enum.map(error, fn x -> convert_to_string(List.first(x)) <> " || " end))} no existen en la base o no son cuentas de detalle. Favor de revisar"}
  defp fill_ids({:error, message}, _), do: {:error, message}
  defp fill_ids({:ok, data}, db_data), do: {:ok, Enum.map(data, fn x -> complete_values(x) ++ [get_id_from_base(x, db_data)] end)}
  defp get_id_from_base(x, db_data), do: Enum.at(Enum.find(db_data, fn row -> Enum.at(row, 1) == List.first(x) end), 0)
  defp convert_to_string(nil), do: "NULO"
  defp convert_to_string(algo), do: algo
  defp complete_values(list), do: list ++ List.duplicate(nil, Enum.count(Xlsx.get_header) - Enum.count(list))

  #******************************VALIDATE CONCEPT*************************************
  defp nonexisting_concept([], data), do: {:ok, data}
  defp nonexisting_concept(_, _), do: {:error, "No puede haber conceptos vacíos"}

  #******************************VALIDATE CREDIT AND DEBIT*************************************
  defp just_one_value(val, debit) when (val == nil or val == 0) and debit >= 0, do: true
  defp just_one_value(credit, val) when (val == nil or val == 0) and credit >= 0, do: true
  defp just_one_value(_, _), do: false
  defp evaluate_debit_credit([], data), do: {:ok, data}
  defp evaluate_debit_credit(error, _), do: {:error, "Las cuentas #{List.to_string(Enum.map(error, fn x -> convert_to_string(List.first(x)) <> " || " end))} tienen valores en debe y haber mayores a cero, favor de revisar"}


  #******************************Convert to MAP And validate values*********************
  defp create_map(data) do
    Map.new
      |> Map.put(:account, Enum.at(data, 0))
      |> Map.put(:aux_concept, Enum.at(data, 1))
      |> Map.put(:credit, Generic.to_float(Enum.at(data, 4)))
      |> Map.put(:debit, Generic.to_float(Enum.at(data, 3)))
      |> Map.put(:department, Enum.at(data, 2))
      |> Map.put(:id_account, Enum.at(data, 5))
      |> Map.put(:id_aux, "")
      |> Map.put(:name, Enum.at(data, 6))
      |> Map.put(:xml_name, Generic.to_string_empty)
      |> Map.put(:xml_id, Generic.to_string_empty)
      |> Map.put(:xml_b64, Generic.to_string_empty)
      |> Map.put(:xml_name_file, Generic.to_string_empty)
  end
  defp add_id_number({data, id}) do
    data
      |> Map.put(:id, id)
      |> Map.put(:number, id)
  end

  #*******************************ERROR OR PASSSS*************************************************
  defp error_or_pass({:error, message}, socket) do
    NotificationComponent.set_timer_notification_error()
    {:noreply, assign(socket, error: message, change: !socket.assigns.change)}
  end
  defp error_or_pass(data, socket), do: {:noreply, assign(socket, pollys: Map.merge(socket.assigns.pollys, data.pollys), arr: data.arr)}

  #********************************END OF LOAD EXCEL************************************************************************^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  defp totals("", params, socket) do
    params = Generic.string_map_to_atom(params)
    sumh = socket.assigns.pollys.sum_haber
    sumd = socket.assigns.pollys.sum_debe
    sumhe = sumh + void(params.credit)
    sumde = sumd + void(params.debit)
    sumtot = sumhe - sumde
    clean = %{account: "", aux_concept: socket.assigns.pollys.concept, credit: "0", debit: "0", department: "", id_account: "", name: "", id_aux: ""}
    pollys = socket.assigns.pollys
      |> Map.put(:sum_haber, sumhe |> Float.round(2))
      |> Map.put(:sum_debe, sumde |> Float.round(2))
      |> Map.put(:total, sumtot |> Float.round(2))
      |> Map.merge(clean)
    params = params
                |> Map.put(:id, get_max_id(socket.assigns.arr, socket.assigns.id))
                |> Map.put(:number, arr_max_number(socket.assigns.arr))
                |> Map.put(:xml_id, Generic.to_string_empty)
    {:noreply, assign(socket, arr: socket.assigns.arr ++ [params], pollys: pollys, xml_name: Generic.to_string_empty, xml_b64: Generic.to_string_empty, req_xml: false)}
  end

  defp totals(_, params, socket) do
    IO.inspect(params, label: "PARAAAAAAAAAAMSSSSSSSS----------------------------------->")
    IO.inspect(socket.assigns.arr, label: "AAAAAAAAAAAAAAAARRRRRRRRRRRRRRRRRR----------------------------------->")
    params = Generic.string_map_to_atom(params)
    sumh = socket.assigns.pollys.sum_haber
    sumd = socket.assigns.pollys.sum_debe
    old_aux = Enum.find(socket.assigns.arr, fn x -> x.id == String.to_integer(params.id_aux) end)
    sumhe = sumh + to_float(void(params.credit)) - to_float(old_aux.credit)
    sumde = sumd + to_float(void(params.debit)) - to_float(old_aux.debit)
    sumtot = sumhe - sumde
    clean = %{account: "", aux_concept: socket.assigns.pollys.concept, credit: "0", debit: "0", department: "", id_account: "", name: "", id_aux: ""}
    pollys = socket.assigns.pollys
      |> Map.put(:sum_haber, sumhe |> Float.round(2))
      |> Map.put(:sum_debe, sumde |> Float.round(2))
      |> Map.put(:total, sumtot |> Float.round(2))
      |> Map.merge(clean)
    new_arr = Enum.filter(socket.assigns.arr, fn x -> x.id != String.to_integer(params.id_aux) end)
    params = params
              |> Map.put(:id, String.to_integer(params.id_aux))
              |> Map.put(:number, Enum.find(socket.assigns.arr, fn aux -> aux.id == String.to_integer(params.id_aux) end).number)
              |> Map.put(:xml_id, Enum.find(socket.assigns.arr, fn aux -> aux.id == String.to_integer(params.id_aux) end).xml_id)
    {:noreply, assign(socket, arr: new_arr ++ [params], pollys: pollys, xml_name: Generic.to_string_empty, xml_b64: Generic.to_string_empty, req_xml: false)}
  end

  defp arr_max_number([]) do
    0
  end

  defp arr_max_number(arr) do
    Enum.max_by(arr, fn number -> number.number end).number + 1
  end

  defp save_auxiliaries(policy_number, policy_id, auxiliaries) do
    db_aux = AccountingSystem.AuxiliaryHandler.get_auxiliary_by_policy_id(policy_id)
    Enum.each(auxiliaries, fn aux -> create_aux(aux, db_aux, policy_id, policy_number) end)
    Enum.reject(db_aux, fn aux -> update_auxiliar(aux, auxiliaries) end)
      |> Enum.each(fn aux-> delete_aux(aux) end)

  end

  defp create_aux(aux_one, aux_list, policy_id, policy_number) do
    aux_one = Auxiliar.format_to_save(aux_one, policy_number, policy_id)
    case Enum.find(aux_list, fn aux -> aux.id == aux_one.id end) do
      nil ->
        AccountingSystem.AuxiliaryHandler.create_auxiliary(aux_one)
      _ ->
        :error
    end
  end

  defp update_auxiliar(auxiliar_db, auxiliaries) do
    #REGRESA LOS AUXILIARES QUE NO FUERON ACTUALIZADOS
    case Enum.find(auxiliaries, fn aux -> aux.id == auxiliar_db.id end) do
      nil ->
        false
      finded ->
        case (AccountingSystem.AuxiliaryHandler.update_auxiliary(auxiliar_db.id |> AccountingSystem.AuxiliaryHandler.get_auxiliary!, AccountingSystem.AuxiliaryHandler.format_to_update(finded) )) do
          {:ok, _} -> true
          _ -> :error
        end
    end
  end

  defp delete_aux([]) do
    :void
  end

  defp delete_aux(auxiliaries) do
    AccountingSystem.AuxiliaryHandler.delete_auxiliary(Map.merge(%AccountingSystem.AuxiliarySchema{}, auxiliaries))
  end

  defp convert_to_aux_schema(params, policy_number, policy_id) do
    Map.merge(%AccountingSystem.AuxiliarySchema{},Auxiliar.format_to_save(params, policy_number, policy_id))
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

  defp check(params, %{"_target" => ["audited"]}) do
    if(params["audited"] == "unchecked", do: params |> Map.put("audited", "checked"), else: params |> Map.put("audited", "unchecked"))
  end

  defp check(params, %{"_target" => ["has_documents"]}) do
    if(params["has_documents"] == "unchecked" , do: params |> Map.put("has_documents", "checked"), else: params |> Map.put("has_documents", "unchecked"))
  end

  defp check(params, _) do
    params
  end

  defp debit_credit_values(params, %{"_target" => ["debit"]}) do
    Map.merge(params, %{"credit" => "0"} )
  end

  defp debit_credit_values(params, %{"_target" => ["credit"]}) do
    Map.merge(params, %{"debit" => "0"} )
  end

  defp debit_credit_values(params, _) do
    params
  end

  defp search_account(text, %{"_target" => ["account"]}) do
    AccountingSystem.AccountHandler.search_detail_account(text)
  end

  defp search_account(_, _) do
    []
  end

  defp checked("checked"), do: true
  defp checked("unchecked"), do: false
  defp checked(nil), do: false

  defp fill(params) do
    id = params["id"]
    policy = id |> AccountingSystem.PolicyHandler.get_policy!
    aux = policy.id |> AccountingSystem.AuxiliaryHandler.get_auxiliary_by_policy_id
      |> Enum.map(fn x -> add_necesaries_to_aux(x) end)
    %{
      dropdowns: [],
      arr: aux,
      edit: true,
      id: params["id"],
      pollys: %{
            audited: (if policy.audited == true, do: "checked", else: "unchecked"),
            concept: policy.concept,
            fiscal_exercise: policy.fiscal_exercise,
            has_documents: (if policy.has_documents == true, do: "checked", else: "unchecked"),
            period: policy.period,
            policy_date: policy.policy_date,
            policy_type: Integer.to_string(policy.policy_type),
            aux_concept: "",
            debit: 0,
            department: "",
            credit: 0,
            id: policy.id,
            sum_haber: sum_list(aux, "H"),
            sum_debe: sum_list(aux, "D"),
            total: 0,
            focused: 0,
            account: "",
            name: "",
            id_account: "",
            serial: policy.serial,
            policy_number: policy.policy_number,
            id_aux: "",
            status: policy.status,
            xml_name: Generic.to_string_empty,
            xml_b64: Generic.to_string_empty,
            req_xml: false
      },
      update_text: "",
      cancel?: false
    }
  end

  defp add_necesaries_to_aux(x) do
    x
    |> Map.merge(get_credit_debit(x))
  end

  defp get_credit_debit(%{amount: amount, debit_credit: deb}) when deb == "D" do
    %{debit: amount, credit: 0}
  end

  defp get_credit_debit(%{amount: amount, debit_credit: deb}) when deb == "H" do
    %{credit: amount, debit: 0}
  end

  defp sum_list([h|t], type) do
    if h.debit_credit == type, do: h.amount + sum_list(t, type), else: sum_list(t, type)
  end

  defp sum_list([], _type) do
    0
  end

  defp get_max_id([], _) do
    0
  end

  defp get_max_id(arr, 0) do
    Enum.max_by(arr, fn x -> x.id end).id + 1
  end

  defp get_max_id(arr, polly_id) do
    max(Enum.max_by(arr, fn x -> x.id end).id + 1,  Auxiliar.get_max_id_by_policy(polly_id) + 1)
  end

  defp to_float(x) when is_bitstring(x), do: void(x)
  defp to_float(x) when is_integer(x), do: x/1
  defp to_float(x) when is_float(x), do: x

  def render(assigns) do
    ~L"""
    <%= if @message do %>
      <%= live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "notification_comp", message: @message, show: true, notification_type: "notification", change: @change) %>
    <% end %>

    <%= if @error do %>
      <%= live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "error_comp", message: @error, show: true, notification_type: "error", change: @change) %>
    <% end %>

    <div id="list_comp" class="flex-none bg-white h-hoch-93 w-80 mt-16 ml-16 block float-left">
      <div class="w-full py-2 bg-blue-700">
        <p class="ml-2 font-bold text-lg text-white">Pólizas</p>
      </div>

      <div class="relative w-full px-2 mt-2">
        <label><b> Tipo de póliza </b></label>

        <div class="w-auto inline-block ml-mar-44">
          <button phx-target="#list_comp" phx-click="pending" class="items-center inline-flex font-bold rounded text-sm tooltip">
          <%= if @filter_activated == true do %>
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"
            class="h-5 w-6 ">
            <path fill="teal" fill-opacity="0.7" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z" class="">
            </path>
            </svg>
          <%= else %>
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye-slash" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"
            class="h-5 w-6 ">
            <path fill="gray" d="M320 400c-75.85 0-137.25-58.71-142.9-133.11L72.2 185.82c-13.79 17.3-26.48 35.59-36.72 55.59a32.35 32.35 0 0 0 0 29.19C89.71 376.41 197.07 448 320 448c26.91 0 52.87-4 77.89-10.46L346 397.39a144.13 144.13 0 0 1-26 2.61zm313.82 58.1l-110.55-85.44a331.25 331.25 0 0 0 81.25-102.07 32.35 32.35 0 0 0 0-29.19C550.29 135.59 442.93 64 320 64a308.15 308.15 0 0 0-147.32 37.7L45.46 3.37A16 16 0 0 0 23 6.18L3.37 31.45A16 16 0 0 0 6.18 53.9l588.36 454.73a16 16 0 0 0 22.46-2.81l19.64-25.27a16 16 0 0 0-2.82-22.45zm-183.72-142l-39.3-30.38A94.75 94.75 0 0 0 416 256a94.76 94.76 0 0 0-121.31-92.21A47.65 47.65 0 0 1 304 192a46.64 46.64 0 0 1-1.54 10l-73.61-56.89A142.31 142.31 0 0 1 320 112a143.92 143.92 0 0 1 144 144c0 21.63-5.29 41.79-13.9 60.11z" class="">
            </path>
            </svg>
          <% end %>
          <span class='tooltip-text font-light text-sm text-white bg-blue-500 mt-5 -ml-12 rounded'><%= if @filter_activated == true, do: "Ver todas", else: "Ver pendientes" %></span>
          <iframe id="invisible" style="display:none;"></iframe>
        </button>
      </div>

        <div class="inline-block relative w-full">
        <form phx-change="type_selected" phx-target="#list_comp">
          <select name="policy_type_selected" class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline">
            <%= for item <- @policytypes do %>
              <option  value="<%= item.id %>" <%= if @type_id_selected == item.id, do: 'selected' %> >
                <%= item.name %>
              </option>
            <% end %>
          </select>
          </form>
          <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
          </div>
        </div>
      </div>

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
    <div class="inline-flex w-full mt-4" >
      <div class="w-1/2 px-2">
        <button phx-click="create_new" phx-value-id="xxx" phx-target="#list_comp" class="py-2 bg-teal-500 hover:bg-teal-400 text-white items-center inline-flex font-bold rounded text-sm w-full ">
          <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
          class="h-4 w-4 mr-2 ml-auto">
            <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"
            class="text-white">
            </path>
          </svg>
          <label class="cursor-pointer mr-auto text-white">Nueva</label>
        </button>
      </div>

      <div class="w-1/2 px-2 text-right">
        <button phx-click="set_series" phx-target="#list_comp" phx-hook="download_template" class="tooltip">
          <label for="xlsx-download" class="custom-file-upload border w-10 bg-teal-500 rounded text-white hover:bg-teal-400">
            <i class="fa fa-cloud-upload"></i>
            <svg aria-hidden="true" focusable="false" data-prefix="far" data-icon="upload" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="h-6 w-6 -ml-1"><path fill="currentColor" d="M224 136V0H24C10.7 0 0 10.7 0 24v464c0 13.3 10.7 24 24 24h336c13.3 0 24-10.7 24-24V160H248c-13.2 0-24-10.8-24-24zm76.45 211.36l-96.42 95.7c-6.65 6.61-17.39 6.61-24.04 0l-96.42-95.7C73.42 337.29 80.54 320 94.82 320H160v-80c0-8.84 7.16-16 16-16h32c8.84 0 16 7.16 16 16v80h65.18c14.28 0 21.4 17.29 11.27 27.36zM377 105L279.1 7c-4.5-4.5-10.6-7-17-7H256v128h128v-6.1c0-6.3-2.5-12.4-7-16.9z" class=""></path></svg>
          </label>
          <label id="xlsx-download"></label>
          <span class='tooltip-text font-light text-sm text-white bg-blue-500 mt-5 -ml-12 rounded'>Descargar plantilla</span>
          <iframe id="invisible" style="display:none;"></iframe>
        </button>
      </div>
    </div>

    <div class="h-hoch-70 overflow-y-scroll pb-16 mt-2">
      <%= for item <- @policy_list do %>
        <div class="w-full px-2 block">
          <div phx-click="open_policy" phx-value-id="<%= item.id %>" phx-target="#list_comp" class="border cursor-pointer w-full block bg-gray-200 p-3 mt-2 rounded relative hover:bg-gray-300">
          <%= if item.status and item.requires_xml do %>
            <div class="w-full text-right h-3">
              <div class="absolute px-3 text-sm top-1 right-0">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="h-3 svg-inline--fa fa-circle fa-w-16 fa-2x">
                  <path
                  <%= if item.pending_xml do %>
                    style="fill:#AE1717;"
                  <% else %>
                    style="fill:#00D106;"
                  <% end %>
                    d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8z" class="">
                  </path>
                </svg>
              </div>
            </div>
          <% end %>
            <h2 class="text-gray-700 text-xl"><%= item.serial  %>-<%= item.policy_number %></h2>
            <label class="inline-block cursor-pointer text-gray-600 font-bold text-sm">Concepto: <b><%= item.concept %></b></label></br>
            <div class="block relative">
              <label class="inline-block cursor-pointer text-gray-600 font-bold text-sm">Tipo: <b><%= item.type_description %></b></label>
              <div class="absolute bg-<%= if item.status == true, do: "green", else: "red" %>-200 px-3 text-sm font-bold top-0 right-0 rounded-full text-<%= if item.status == true, do: "green", else: "red" %>-700">
                <%= if item.status == true, do: "Activa", else: "Cancelada" %>
              </div>
            </div>
          </div>
        </div>

      <% end %>
    </div>
    </div>

    <%= if @new? do %>
      <%= live_component(@socket, AccountingSystemWeb.NewPolicyComponent, id: 0, update_text: @update_text, pollys: @pollys, arr: @arr, edit: false, update: @update, cancel?: false, dropdowns: @dropdowns, message_confirm: nil, change: @change, xml_name: @xml_name, xml_b64: @xml_b64) %>
    <% end %>

    <%= if @edit? do %>
      <%= live_component(@socket, AccountingSystemWeb.NewPolicyComponent, id: @policy_id, update_text: "", pollys: @pollys, arr: @arr, edit: true, update: @update, cancel?: @cancel?, dropdowns: @dropdowns, message_confirm: @message_confirm, change: @change, xml_name: @xml_name, xml_b64: @xml_b64) %>
    <% end %>
    """
  end
end
