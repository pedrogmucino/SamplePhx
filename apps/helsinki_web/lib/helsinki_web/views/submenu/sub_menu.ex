defmodule AccountingSystemWeb.SubMenuView do
  use AccountingSystemWeb, :view
end

defmodule AccountingSystemWeb.SubMenuLiveView do

  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(AccountingSystemWeb.SubMenuView, "sub_menu.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end

