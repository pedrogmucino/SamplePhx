defmodule AccountingSystemWeb.FormPeriodController do
  use AccountingSystemWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.FormPeriodLiveView, session: %{})
  end
end
