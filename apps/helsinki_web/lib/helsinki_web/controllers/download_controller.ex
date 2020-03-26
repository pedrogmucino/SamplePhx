defmodule AccountingSystemWeb.DownloadController do
  @moduledoc """
  Controller para descarga de archivos
  """
  use AccountingSystemWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    #LiveView.Controller.live_render(conn, AccountingSystemWeb.ConfigurationLiveView, session: %{})
    a = send_download(conn, {:file, "template.xlsx"})
    Task.async(fn ->
      :timer.sleep(4000)
      File.rm("template.xlsx")
    end)
    a
  end
end
