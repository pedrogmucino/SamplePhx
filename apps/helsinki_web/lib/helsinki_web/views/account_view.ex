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

  def handle_info(params, socket) do
    send_update(AccountingSystemWeb.ErrorComponent, id: "error_comp", show: false)
    {:noreply, assign(socket, error: nil)}
  end
end
