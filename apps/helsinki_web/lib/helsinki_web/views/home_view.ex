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

end

