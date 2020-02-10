defmodule AccountingSystemWeb.PolicyTypeControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.PolicyTipeHandler

  @create_attrs %{identifier: "some identifier", name: "some name"}
  @update_attrs %{identifier: "some updated identifier", name: "some updated name"}
  @invalid_attrs %{identifier: nil, name: nil}

  def fixture(:policy_type) do
    {:ok, policy_type} = PolicyTipeHandler.create_policy_type(@create_attrs)
    policy_type
  end

  describe "index" do
    test "lists all policytypes", %{conn: conn} do
      conn = get(conn, Routes.policy_type_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Policytypes"
    end
  end

  describe "new policy_type" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.policy_type_path(conn, :new))
      assert html_response(conn, 200) =~ "New Policy type"
    end
  end

  describe "create policy_type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.policy_type_path(conn, :create), policy_type: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.policy_type_path(conn, :show, id)

      conn = get(conn, Routes.policy_type_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Policy type"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.policy_type_path(conn, :create), policy_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Policy type"
    end
  end

  describe "edit policy_type" do
    setup [:create_policy_type]

    test "renders form for editing chosen policy_type", %{conn: conn, policy_type: policy_type} do
      conn = get(conn, Routes.policy_type_path(conn, :edit, policy_type))
      assert html_response(conn, 200) =~ "Edit Policy type"
    end
  end

  describe "update policy_type" do
    setup [:create_policy_type]

    test "redirects when data is valid", %{conn: conn, policy_type: policy_type} do
      conn = put(conn, Routes.policy_type_path(conn, :update, policy_type), policy_type: @update_attrs)
      assert redirected_to(conn) == Routes.policy_type_path(conn, :show, policy_type)

      conn = get(conn, Routes.policy_type_path(conn, :show, policy_type))
      assert html_response(conn, 200) =~ "some updated identifier"
    end

    test "renders errors when data is invalid", %{conn: conn, policy_type: policy_type} do
      conn = put(conn, Routes.policy_type_path(conn, :update, policy_type), policy_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Policy type"
    end
  end

  describe "delete policy_type" do
    setup [:create_policy_type]

    test "deletes chosen policy_type", %{conn: conn, policy_type: policy_type} do
      conn = delete(conn, Routes.policy_type_path(conn, :delete, policy_type))
      assert redirected_to(conn) == Routes.policy_type_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.policy_type_path(conn, :show, policy_type))
      end
    end
  end

  defp create_policy_type(_) do
    policy_type = fixture(:policy_type)
    {:ok, policy_type: policy_type}
  end
end
