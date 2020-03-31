defmodule AccountingSystemWeb.FormQueryPeriodController do
  use AccountingSystemWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.FormQueryPeriodLiveView, session: %{})
  end
end
