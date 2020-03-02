defmodule AccountingSystemWeb.SeriesControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.Accounts

  @create_attrs %{current_number: 42, number: 42, serial: "some serial"}
  @update_attrs %{current_number: 43, number: 43, serial: "some updated serial"}
  @invalid_attrs %{current_number: nil, number: nil, serial: nil}

  def fixture(:series) do
    {:ok, series} = Accounts.create_series(@create_attrs)
    series
  end

  describe "index" do
    test "lists all series", %{conn: conn} do
      conn = get(conn, Routes.series_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Series"
    end
  end

  describe "new series" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.series_path(conn, :new))
      assert html_response(conn, 200) =~ "New Series"
    end
  end

  describe "create series" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.series_path(conn, :create), series: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.series_path(conn, :show, id)

      conn = get(conn, Routes.series_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Series"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.series_path(conn, :create), series: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Series"
    end
  end

  describe "edit series" do
    setup [:create_series]

    test "renders form for editing chosen series", %{conn: conn, series: series} do
      conn = get(conn, Routes.series_path(conn, :edit, series))
      assert html_response(conn, 200) =~ "Edit Series"
    end
  end

  describe "update series" do
    setup [:create_series]

    test "redirects when data is valid", %{conn: conn, series: series} do
      conn = put(conn, Routes.series_path(conn, :update, series), series: @update_attrs)
      assert redirected_to(conn) == Routes.series_path(conn, :show, series)

      conn = get(conn, Routes.series_path(conn, :show, series))
      assert html_response(conn, 200) =~ "some updated serial"
    end

    test "renders errors when data is invalid", %{conn: conn, series: series} do
      conn = put(conn, Routes.series_path(conn, :update, series), series: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Series"
    end
  end

  describe "delete series" do
    setup [:create_series]

    test "deletes chosen series", %{conn: conn, series: series} do
      conn = delete(conn, Routes.series_path(conn, :delete, series))
      assert redirected_to(conn) == Routes.series_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.series_path(conn, :show, series))
      end
    end
  end

  defp create_series(_) do
    series = fixture(:series)
    {:ok, series: series}
  end
end
