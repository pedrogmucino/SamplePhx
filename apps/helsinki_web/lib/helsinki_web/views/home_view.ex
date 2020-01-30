defmodule AccountingSystemWeb.HomeView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.HomeLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.HomeView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("open_submenu", value, socket) do
    IO.inspect(value["atom"], label: "valor que recibi ===> ")
    {:noreply, socket}
  end

end

