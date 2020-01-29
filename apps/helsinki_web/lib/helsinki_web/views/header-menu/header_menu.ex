defmodule AccountingSystemWeb.HeaderMenuView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.HeaderMenuLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.HeaderMenuView, "header_menu.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

