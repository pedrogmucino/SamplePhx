defmodule AccountingSystemWeb.SubAccountsController do
  use AccountingSystemWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.SubAccountsLiveView, session: %{})
  end
end
