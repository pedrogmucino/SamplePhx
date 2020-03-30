defmodule AccountingSystemWeb.ShowXmlController do
  use AccountingSystemWeb, :controller

  def show(conn, params) do
    file_name = params["xml_name"] |> String.replace(" ", "")
    data = AccountingSystem.AuxiliaryHandler.get_xml_file_to_alexandria(params["xml_id"])
    conn
    |> put_resp_content_type("application/xml")
    |> put_resp_header("content-disposition", "attachment; filename=#{file_name}")
    |> Plug.Conn.send_resp(:ok, data)
  end

end
