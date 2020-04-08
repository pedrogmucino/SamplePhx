defmodule AccountingSystemWeb.BalanceController do
  use AccountingSystemWeb, :controller

  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.BalanceLiveView, session: %{})
  end
end
