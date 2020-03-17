defmodule AccountingSystemWeb.AccountView do
  use AccountingSystemWeb, :view
end
defmodule AccountingSystemWeb.AccountLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.AccountView, "index_fake.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, child?: false)}
  end

  def handle_info({_reference, %{message: params}}, socket) do
    case params do
      "close_error" ->
        send_update(AccountingSystemWeb.NotificationComponent, id: "error_comp", show: false)

      "close_notification" ->
        send_update(AccountingSystemWeb.NotificationComponent, id: "notification_comp", show: false)
    end
    {:noreply, socket}
  end

  def handle_info({:DOWN, _reference, _process, _pid, _normal}, socket) do
    {:noreply, socket}
  end
end
