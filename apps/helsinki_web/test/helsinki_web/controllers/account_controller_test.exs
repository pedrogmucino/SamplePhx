defmodule AccountingSystemWeb.AccountControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.Accounts

  @create_attrs %{apply_third_party_to: "some apply_third_party_to", apply_to: 42, character: true, code: "some code", group_code: 42, is_departamental: true, name: "some name", parent_account: 42, payment_method: true, root_account: 42, status: "some status", third_party_op: true, third_party_prosecutor: 42, type: "some type", uuid_voucher: "some uuid_voucher"}
  @update_attrs %{apply_third_party_to: "some updated apply_third_party_to", apply_to: 43, character: false, code: "some updated code", group_code: 43, is_departamental: false, name: "some updated name", parent_account: 43, payment_method: false, root_account: 43, status: "some updated status", third_party_op: false, third_party_prosecutor: 43, type: "some updated type", uuid_voucher: "some updated uuid_voucher"}
  @invalid_attrs %{apply_third_party_to: nil, apply_to: nil, character: nil, code: nil, group_code: nil, is_departamental: nil, name: nil, parent_account: nil, payment_method: nil, root_account: nil, status: nil, third_party_op: nil, third_party_prosecutor: nil, type: nil, uuid_voucher: nil}

  def fixture(:account) do
    {:ok, account} = Accounts.create_account(@create_attrs)
    account
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Accounts"
    end
  end

  describe "new account" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :new))
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "create account" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.account_path(conn, :show, id)

      conn = get(conn, Routes.account_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Account"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "edit account" do
    setup [:create_account]

    test "renders form for editing chosen account", %{conn: conn, account: account} do
      conn = get(conn, Routes.account_path(conn, :edit, account))
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "update account" do
    setup [:create_account]

    test "redirects when data is valid", %{conn: conn, account: account} do
      conn = put(conn, Routes.account_path(conn, :update, account), account: @update_attrs)
      assert redirected_to(conn) == Routes.account_path(conn, :show, account)

      conn = get(conn, Routes.account_path(conn, :show, account))
      assert html_response(conn, 200) =~ "some updated apply_third_party_to"
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, Routes.account_path(conn, :update, account), account: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, Routes.account_path(conn, :delete, account))
      assert redirected_to(conn) == Routes.account_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.account_path(conn, :show, account))
      end
    end
  end

  defp create_account(_) do
    account = fixture(:account)
    {:ok, account: account}
  end
end
