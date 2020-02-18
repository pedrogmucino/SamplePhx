defmodule AccountingSystemWeb.ActivesView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.ActivesLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.ActivesView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

