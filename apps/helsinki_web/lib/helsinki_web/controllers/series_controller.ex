defmodule AccountingSystemWeb.SeriesController do
  use AccountingSystemWeb, :controller

  alias AccountingSystem.{
    SeriesHandler,
    SeriesSchema
   }
   alias Phoenix.LiveView

  # def index(conn, _params) do
  #   series = SeriesHandler.list_series()
  #   render(conn, "index.html", series: series)
  # end

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.SeriesLiveView, session: %{})
  end

  def new(conn, _params) do
    changeset = SeriesHandler.change_series(%SeriesSchema{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"series_schema" => series_params}) do
    case SeriesHandler.create_series(series_params) do
      {:ok, series} ->
        conn
        |> put_flash(:info, "Series created successfully.")
        |> redirect(to: Routes.series_path(conn, :show, series))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    series = SeriesHandler.get_series!(id)
    render(conn, "show.html", series: series)
  end

  def edit(conn, %{"id" => id}) do
    series = SeriesHandler.get_series!(id)
    changeset = SeriesHandler.change_series(series)
    render(conn, "edit.html", series: series, changeset: changeset)
  end

  def update(conn, %{"id" => id, "series_schema" => series_params}) do
    series = SeriesHandler.get_series!(id)

    case SeriesHandler.update_series(series, series_params) do
      {:ok, series} ->
        conn
        |> put_flash(:info, "Series updated successfully.")
        |> redirect(to: Routes.series_path(conn, :show, series))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", series: series, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    series = SeriesHandler.get_series!(id)
    {:ok, _series} = SeriesHandler.delete_series(series)

    conn
    |> put_flash(:info, "Series deleted successfully.")
    |> redirect(to: Routes.series_path(conn, :index))
  end
end
