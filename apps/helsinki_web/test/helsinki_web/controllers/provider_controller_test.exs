defmodule AccountingSystemWeb.ProviderControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.ProviderHandler

  @create_attrs %{provider_name: "some provider_name", rfc_provider: "some rfc_provider"}
  @update_attrs %{provider_name: "some updated provider_name", rfc_provider: "some updated rfc_provider"}
  @invalid_attrs %{provider_name: nil, rfc_provider: nil}

  def fixture(:provider) do
    {:ok, provider} = ProviderHandler.create_provider(@create_attrs)
    provider
  end

  describe "index" do
    test "lists all providers", %{conn: conn} do
      conn = get(conn, Routes.provider_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Providers"
    end
  end

  describe "new provider" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.provider_path(conn, :new))
      assert html_response(conn, 200) =~ "New Provider"
    end
  end

  describe "create provider" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.provider_path(conn, :create), provider: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.provider_path(conn, :show, id)

      conn = get(conn, Routes.provider_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Provider"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.provider_path(conn, :create), provider: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Provider"
    end
  end

  describe "edit provider" do
    setup [:create_provider]

    test "renders form for editing chosen provider", %{conn: conn, provider: provider} do
      conn = get(conn, Routes.provider_path(conn, :edit, provider))
      assert html_response(conn, 200) =~ "Edit Provider"
    end
  end

  describe "update provider" do
    setup [:create_provider]

    test "redirects when data is valid", %{conn: conn, provider: provider} do
      conn = put(conn, Routes.provider_path(conn, :update, provider), provider: @update_attrs)
      assert redirected_to(conn) == Routes.provider_path(conn, :show, provider)

      conn = get(conn, Routes.provider_path(conn, :show, provider))
      assert html_response(conn, 200) =~ "some updated provider_name"
    end

    test "renders errors when data is invalid", %{conn: conn, provider: provider} do
      conn = put(conn, Routes.provider_path(conn, :update, provider), provider: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Provider"
    end
  end

  describe "delete provider" do
    setup [:create_provider]

    test "deletes chosen provider", %{conn: conn, provider: provider} do
      conn = delete(conn, Routes.provider_path(conn, :delete, provider))
      assert redirected_to(conn) == Routes.provider_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.provider_path(conn, :show, provider))
      end
    end
  end

  defp create_provider(_) do
    provider = fixture(:provider)
    {:ok, provider: provider}
  end
end
