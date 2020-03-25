defmodule AccountingSystemWeb.ShowXmlView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.ShowXmlLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.ShowXmlView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

