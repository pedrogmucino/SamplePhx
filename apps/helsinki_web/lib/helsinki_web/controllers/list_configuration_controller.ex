defmodule AccountingSystemWeb.ListConfigurationController do
  use AccountingSystemWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.ListConfigurationLiveView, session: %{})
  end
end
