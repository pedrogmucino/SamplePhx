defmodule AccountingSystemWeb.SubMenuController do
  use AccountingSystemWeb, :controller
  alias Phoenix.LiveView

  def sub_menu(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.SubMenuLiveView, session: %{})
  end
end
