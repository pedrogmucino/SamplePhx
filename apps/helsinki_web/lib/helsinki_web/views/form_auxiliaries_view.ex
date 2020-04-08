
defmodule AccountingSystemWeb.FormAuxiliariesView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.FormAuxiliariesLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.FormAuxiliariesView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_info({_reference, %{message: params}}, socket) do
    case params do
      "close_error" -> send_update(AccountingSystemWeb.NotificationComponent, id: "error_comp", show: false)
      "close_notification" -> send_update(AccountingSystemWeb.NotificationComponent, id: "notification_comp", show: false)
    end
    {:noreply, socket}
  end

  def handle_info({:DOWN, _reference, _process, _pid, _normal}, socket) do
    {:noreply, socket}
  end

  def handle_event("send_to_view_start", params, socket) do
    start_date = params["start_date"]
    send_update(AccountingSystemWeb.FormAuxiliariesComponent, id: "formauxiliaries", start_date: start_date, end_date: "" )
    {:noreply, socket}
  end

  def handle_event("send_to_view_end", params, socket) do
    end_date = params["end_date"]
    send_update(AccountingSystemWeb.FormAuxiliariesComponent, id: "formauxiliaries", start_date: "", end_date: end_date )
    {:noreply, socket}
  end

end

