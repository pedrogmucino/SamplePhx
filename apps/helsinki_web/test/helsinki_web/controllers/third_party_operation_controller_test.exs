defmodule AccountingSystemWeb.ThirdPartyOperationControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.ThirdPartyOperationHandler

  @create_attrs %{account_number: "some account_number", policy_id: 42, provider_id: 42}
  @update_attrs %{account_number: "some updated account_number", policy_id: 43, provider_id: 43}
  @invalid_attrs %{account_number: nil, policy_id: nil, provider_id: nil}

  def fixture(:third_party_operation) do
    {:ok, third_party_operation} = ThirdPartyOperationHandler.create_third_party_operation(@create_attrs)
    third_party_operation
  end

  describe "index" do
    test "lists all thirdpartyoperations", %{conn: conn} do
      conn = get(conn, Routes.third_party_operation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Thirdpartyoperations"
    end
  end

  describe "new third_party_operation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.third_party_operation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Third party operation"
    end
  end

  describe "create third_party_operation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.third_party_operation_path(conn, :create), third_party_operation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.third_party_operation_path(conn, :show, id)

      conn = get(conn, Routes.third_party_operation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Third party operation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.third_party_operation_path(conn, :create), third_party_operation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Third party operation"
    end
  end

  describe "edit third_party_operation" do
    setup [:create_third_party_operation]

    test "renders form for editing chosen third_party_operation", %{conn: conn, third_party_operation: third_party_operation} do
      conn = get(conn, Routes.third_party_operation_path(conn, :edit, third_party_operation))
      assert html_response(conn, 200) =~ "Edit Third party operation"
    end
  end

  describe "update third_party_operation" do
    setup [:create_third_party_operation]

    test "redirects when data is valid", %{conn: conn, third_party_operation: third_party_operation} do
      conn = put(conn, Routes.third_party_operation_path(conn, :update, third_party_operation), third_party_operation: @update_attrs)
      assert redirected_to(conn) == Routes.third_party_operation_path(conn, :show, third_party_operation)

      conn = get(conn, Routes.third_party_operation_path(conn, :show, third_party_operation))
      assert html_response(conn, 200) =~ "some updated account_number"
    end

    test "renders errors when data is invalid", %{conn: conn, third_party_operation: third_party_operation} do
      conn = put(conn, Routes.third_party_operation_path(conn, :update, third_party_operation), third_party_operation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Third party operation"
    end
  end

  describe "delete third_party_operation" do
    setup [:create_third_party_operation]

    test "deletes chosen third_party_operation", %{conn: conn, third_party_operation: third_party_operation} do
      conn = delete(conn, Routes.third_party_operation_path(conn, :delete, third_party_operation))
      assert redirected_to(conn) == Routes.third_party_operation_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.third_party_operation_path(conn, :show, third_party_operation))
      end
    end
  end

  defp create_third_party_operation(_) do
    third_party_operation = fixture(:third_party_operation)
    {:ok, third_party_operation: third_party_operation}
  end
end
