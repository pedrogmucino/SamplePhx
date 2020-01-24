defmodule AccountingSystemWeb.PageController do
  use AccountingSystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
