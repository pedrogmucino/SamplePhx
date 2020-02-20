defmodule AccountingSystemWeb.PolicyView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.PolicyLiveView do
  use Phoenix.LiveView
  alias AccountingSystem.PolicyHandler
  alias AccountingSystem.PolicySchema

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.PolicyView, "new.html", assigns)
  end

  def mount(_params, _session, socket) do
    dropdowns = AccountingSystem.AccountHandler.get_all_as_list
    policytypes = AccountingSystem.PolicyTipeHandler.get_all_as_list
    changeset = PolicyHandler.change_policy(%PolicySchema{})
    actual = %{"concept" => "", "debe" => "", "department" => "", "haber" => "", "id_account" => "", "sum_haber" => 0, "sum_debe" => 0, "total" => 0}
    pollys = %{"audited" => false, "concept" => "", "fiscal_exercise" => "", "has_documents" => false, "period" => "", "policy_date" => %{"day" => "1", "month" => "2", "year" => "2020"}, "policy_number" => 0, "policy_type" => "2"}
    {:ok, assign(socket, dropdowns: dropdowns, arr: [], actual: actual, changeset: changeset, policytypes: policytypes, pollys: pollys)}
  end

  def handle_event("fu", params, socket) do
    case AccountingSystem.AuxiliaryHandler.validate_auxiliar(params) do
      {:ok, _} ->
        totals(params, socket)
      {:error, _} ->
        {:noreply, socket}
    end
  end

  def handle_event("save", params, socket) do
    case PolicyHandler.save_policy(params, socket) do
      {:ok, _} ->
        {:stop, redirect(socket, to: AccountingSystemWeb.Router.Helpers.policy_path(AccountingSystemWeb.Endpoint, :index, %{}))}
      {:error, _} ->
        {:noreply, socket |> put_flash(:error, "NO SE PUDO GUARDAR")}
    end
  end

  def handle_event("save_change", params, socket) do
    pollys = params["policy_schema"]
    {:noreply, assign(socket, pollys: pollys)}
  end

  def handle_event("editar", params, socket) do
    actual = socket.assigns.arr |> Enum.find(fn elto -> elto["id"] == params["id"] |> String.to_integer end)
    {:noreply, assign(socket, actual: actual)}
  end

  def handle_event("search",%{"value" => value}, socket) do
    dropdowns = AccountingSystem.SearchAccount.search(value)
                  |> AccountingSystem.Repo.all
                  |> IO.inspect
    {:noreply, assign(socket, dropdowns: dropdowns)}
  end

  defp totals(params, socket) do
    sumh = socket.assigns.actual["sum_haber"]
    sumd = socket.assigns.actual["sum_debe"]
    sumhe = sumh + void(params["haber"])
    sumde = sumd + void(params["debe"])
    sumtot = sumhe - sumde
    actual = socket.assigns.actual
      |> Map.put("sum_haber", sumhe |> Float.round(2))
      |> Map.put("sum_debe", sumde |> Float.round(2))
      |> Map.put("total", sumtot |> Float.round(2))
    {:noreply, assign(socket, arr: socket.assigns.arr ++ [params |> Map.put("id", length(socket.assigns.arr))], actual: actual)}
  end

  defp void(some) do
    case some do
      "" -> 0.0
      _ -> some
            |> Float.parse
            |> Tuple.to_list
            |> List.first
    end
  end
end

defmodule AccountingSystemWeb.PolicyListLiveView do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.PolicyView, "index_new.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
