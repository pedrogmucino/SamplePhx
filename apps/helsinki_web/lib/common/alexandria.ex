defmodule AccountingSystemWeb.Alexandria do
  import Ecto
  def get_file(id, parts) do
    Application.get_env(:helsinki_web, Alexandria)[:url]
    |> URI.merge(id <> "/" <> Integer.to_string(parts))
    |> URI.to_string
    |> HTTPoison.get(recv_timeout: 800_000)
  end

  def upload_file(file, name) do
    uuid = Ecto.UUID.generate
    upload_put(file, uuid)
    |> upload_post(name)
  end

  def upload_file(file, name, uuid) do
    upload_put(file, uuid)
    |> upload_post(name)
  end

  defp upload_put(file, uuid) do
    Application.get_env(:helsinki_web, Alexandria)[:url]
    |> URI.merge(uuid)
    |> URI.to_string
    |> HTTPoison.put(file)
    uuid
  end

  defp upload_post(id, name) do
    HTTPoison.start()
    case Application.get_env(:helsinki_web, Alexandria)[:url]
    |> HTTPoison.post(
      request_post_body(id, name),
      [{"Content-Type", "application/json"}]) do
      {:ok, %HTTPoison.Response{} = response} ->
        response.body
      {:error, %HTTPoison.Error{} = error} ->
        case error.reason do
          :timeout ->
            upload_post(id, name)
          _ ->
            nil
        end
    end
  end

  defp request_post_body(id, name) do
    %{"id" => id, "nombre" => name, "sucursal" => 1, "usuario" => 1, "anio" => Date.utc_today.year}
      |> Poison.encode!
  end
end
