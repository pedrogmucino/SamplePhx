defmodule AccountingSystemWeb.Alexandria do
  def get_file(id, parts) do
    Application.get_env(:helsinki_web, Alexandria)[:url]
    |> URI.merge(id <> "/" <> Integer.to_string(parts))
    |> URI.to_string
    |> HTTPoison.get(recv_timeout: 800_000)
  end
end
