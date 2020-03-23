defmodule AccountingSystemWeb.SeriesListComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  import Ecto
  alias AccountingSystem.{
    StructureHandler,
    SeriesHandler,
    EctoUtil
  }
  alias AccountingSystemWeb.{
    Alexandria,
    NotificationComponent
  }

  def mount(socket) do
    {:ok, assign(socket,
    series_list: SeriesHandler.get_series,
    new?: false,
    edit?: false,
    message: nil,
    error: nil,
    change: false
    )}
  end

  def update(attrs, socket) do
    {:ok, assign(socket, id: attrs.id)}
  end

  def handle_event("create_series", params, socket) do
    IO.inspect(params, label: "------------------------------------>PARAMS")
    params = Map.replace!(params, "fiscal_exercise", Integer.to_string(Date.utc_today.year))
    case SeriesHandler.create_series(params) do
      {:ok, series} ->
        NotificationComponent.set_timer_notification()
        {:noreply,
          socket
          |> assign(
            series_list: SeriesHandler.get_series(),
            new?: false,
            edit?: false,
            message: "Serie #{series.serial}-#{series.fiscal_exercise} creada satisfactoriamente",
            error: nil,
            change: !socket.assigns.change)
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        NotificationComponent.set_timer_notification_error()
        {:noreply,
        socket
        |> assign(
          changeset: changeset,
          series_list: SeriesHandler.get_series(),
            new?: false,
            edit?: false,
            message: nil,
            error: "No pudo crearse la serie. Validar lo siguiente:<br>" <> EctoUtil.get_errors(changeset),
            change: !socket.assigns.change
          )}
    end
  end

  def handle_event("open_series", params, socket) do
    assign(socket, series: params["id"])
    id =
    params
    |> Map.get("id")

    {:noreply, assign(socket, new?: false, edit?: true, series_id: id)}
  end

  def handle_event("set_series", params, socket) do
    case Alexandria.get_file(Application.get_env(:helsinki_web, Format)[:file_uuid], 1) do
      {:ok, %HTTPoison.Response{} = response} ->
        if String.contains?(response.body, "\"errors\"") do
          errors = response.body |> IO.inspect(label: "---------------------------------->ERRORES AL RECUPERAR")
        else
          bytes = response.body |> IO.inspect(label: "-------------------------------->BYTES O CONTENIDO DEL ARCHIVO")
        end
      {:error, response} ->
        IO.inspect(response, label: "-------------------------------------->FALLA DEL SERVICIO")
    end

    series =
    params["series_id"]
    |> SeriesHandler.get_series!()
    case SeriesHandler.update_series(series, %{"serial" => params["serial"]}) do
      {:ok, series} ->
        NotificationComponent.set_timer_notification()
        {:noreply,
          socket
          |> assign(
            series_list: SeriesHandler.get_series(),
            new?: false,
            edit?: false,
            message: "Serie #{series.serial}-#{series.fiscal_exercise} actualizada correctamente",
            change: !socket.assigns.change,
            error: nil
            )}
      {:error, %Ecto.Changeset{} = changeset} ->
        NotificationComponent.set_timer_notification_error()
        {:noreply, socket
        |> assign(
          changeset: changeset,
          error: "Serie no puede ser actualizada",
          message: nil,
          change: !socket.assigns.change
          )}
    end
  end

  def handle_event("delete_series", params, socket) do
    params["id"]
    |> SeriesHandler.get_series!
    |> execute_delete(socket)
  end

  defp execute_delete(series, socket) do
    case SeriesHandler.delete_series(series) do
      {:ok, series} ->
        NotificationComponent.set_timer_notification()
        {:noreply,
          socket
          |> assign(
            series_list: SeriesHandler.get_series(),
            new?: false,
            edit?: false,
            message: "Serie #{series.serial}-#{series.fiscal_exercise} eliminada satisfactoriamente",
            error: nil,
            change: !socket.assigns.change)
        }
      {:error, %Ecto.Changeset{} = changeset} ->
        NotificationComponent.set_timer_notification_error()
        {:noreply,
          socket
          |> assign(
            series_list: SeriesHandler.get_series(),
            new?: false,
            edit?: false,
            message: "Serie #{series.serial}-#{series.fiscal_exercise} eliminada satisfactoriamente",
            error: "Serie no pudo ser eliminada. Validar lo siguiente:<br>" <> EctoUtil.get_errors(changeset),
            change: !socket.assigns.change)
        }
    end
  end

  def handle_event("create_new", _params, socket) do
    {:noreply, assign(socket, new?: true, edit?: false)}
  end

  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, new?: false, edit?: false)}
  end

  def render(assigns) do
    ~L"""
    <%= if @message do %>
      <%= live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "notification_comp", message: @message, show: true, notification_type: "notification", change: @change) %>
    <% end %>

    <%= if @error do %>
      <%= live_component(@socket, AccountingSystemWeb.NotificationComponent, id: "error_comp", message: @error, show: true, notification_type: "error", change: @change) %>
    <% end %>

    <div id="series_list" class="bg-white h-hoch-93 w-80 mt-16 ml-16 block float-left">
      <div class="w-full py-2 bg-blue-700">
        <p class="ml-2 font-bold text-lg text-white">Series</p>
      </div>
    <div class="relative w-full px-2 mt-4">
      <input class="focus:outline-none focus:bg-white focus:border-blue-500 h-8 w-full rounded border bg-gray-300 pl-2" placeholder="Buscar Serie" >
      <svg aria-hidden="true" focusable="false" data-prefix="fad" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
        class="absolute right-0 top-0 h-4 w-4 mr-4 mt-2">
        <g>
          <path fill="currentColor" d="M208 80a128 128 0 1 1-90.51 37.49A127.15 127.15 0 0 1 208 80m0-80C93.12 0 0 93.12 0 208s93.12 208 208 208 208-93.12 208-208S322.88 0 208 0z"
          class="text-gray-600">
          </path>
          <path fill="currentColor" d="M504.9 476.7L476.6 505a23.9 23.9 0 0 1-33.9 0L343 405.3a24 24 0 0 1-7-17V372l36-36h16.3a24 24 0 0 1 17 7l99.7 99.7a24.11 24.11 0 0 1-.1 34z"
          class="text-gray-500">
          </path>
        </g>
      </svg>
    </div>

    <div class="w-1/2 px-2 mt-2">
      <button phx-click="create_new" phx-value-id="xxx" phx-target="#series_list" class="py-2 bg-teal-500 hover:bg-teal-400 text-white items-center inline-flex font-bold rounded text-sm w-full ">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
        class="h-4 w-4 mr-2 ml-auto">
          <path fill="currentColor" d="M416 208H272V64c0-17.67-14.33-32-32-32h-32c-17.67 0-32 14.33-32 32v144H32c-17.67 0-32 14.33-32 32v32c0 17.67 14.33 32 32 32h144v144c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32V304h144c17.67 0 32-14.33 32-32v-32c0-17.67-14.33-32-32-32z"
          class="text-white">
          </path>
        </svg>
        <label class="cursor-pointer mr-auto text-white">Nueva</label>
      </button>
    </div>

    <div class="h-hoch-75 overflow-y-scroll pb-16m mt-2">
      <%= for item <- @series_list do %>
        <div class="w-full px-2 block">
          <div phx-click="open_series" phx-value-id="<%= item.id %>" phx-target="#series_list" class="border cursor-pointer w-full inline-block bg-gray-200 p-3 mt-2 rounded relative hover:bg-gray-300">
            <h2 class="text-gray-700 text-xl"><%= item.serial  %><%= item.fiscal_exercise %></h2>
            <label class="cursor-pointer text-gray-600 font-bold text-sm">Tipo: <b><%= item.name %></b></label>
            <br>
            <label class="cursor-pointer text-gray-600 font-bold text-sm">Folio Actual: <b><%= item.current_number %></b></label>
          </div>
        </div>

      <% end %>
    </div>
    </div>

    <%= if @new? do %>
      <%= live_component(@socket, AccountingSystemWeb.SeriesComponent, id: "series") %>
    <% end %>

    <%= if @edit? do %>

      <%= live_component(@socket, AccountingSystemWeb.SeriesEditComponent, id: @series_id) %>
    <% end %>
    """
  end
end
