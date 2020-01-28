defmodule AccountingSystemWeb.PageView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.PageLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.PageView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

