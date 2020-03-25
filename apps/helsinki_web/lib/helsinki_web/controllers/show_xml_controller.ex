defmodule AccountingSystemWeb.ShowXmlController do
  use AccountingSystemWeb, :controller
  alias Phoenix.LiveView

  def index(conn, params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.ShowXmlLiveView, session: %{"xml_id" => params["xml_id"]})
  end
end
