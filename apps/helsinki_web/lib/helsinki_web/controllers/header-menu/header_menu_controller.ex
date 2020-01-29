defmodule AccountingSystemWeb.HeaderMenuController do
  use AccountingSystemWeb, :controller
  alias Phoenix.LiveView

  def header_menu(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.HeaderMenuLiveView, session: %{})
  end
end
