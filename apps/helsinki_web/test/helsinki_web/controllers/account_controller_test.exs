defmodule AccountingSystemWeb.AccountControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.AccountHandler

  @create_attrs %{apply_third_party_to: "no", apply_to: 42, character: false, code: "1-000-00-00000-000", group_code: 42, is_departamental: false, name: "Activos", parent_account: 42, payment_method: true, root_account: 1, status: "a", third_party_op: true, third_party_prosecutor: 42, type: "d", uuid_voucher: "some uuid_voucher", level: "0", description: "description", name2: "C-"}
  @invalid_attrs %{apply_third_party_to: nil, apply_to: nil, character: nil, code: "1", group_code: nil, is_departamental: nil, name: "", parent_account: nil, payment_method: nil, root_account: nil, status: nil, third_party_op: nil, third_party_prosecutor: nil, type: nil, uuid_voucher: nil, level: "0", name2: ""}
  @invalid_attrs3 %{"apply_third_party_to" => nil, "apply_to" => nil, "character" => nil, "code" => "1", "group_code" => nil, "is_departamental" => nil, "name" => "", "parent_account" => nil, "payment_method" => nil, "root_account" => nil, "status" => nil, "third_party_op" => nil, "third_party_prosecutor" => nil, "type" => nil, "uuid_voucher" => nil, "level" => "0"}
  @valid_attrs3 %{"apply_third_party_to" => "no", "apply_to" => 42, "character" => false, "code" => "1-000-00-00000-000", "group_code" => 42, "is_departamental" => false, "name" => "Activos", "parent_account" => 42, "payment_method" => true, "root_account" => 1, "status" => "a", "third_party_op" => true, "third_party_prosecutor" => 42, "type" => "d", "uuid_voucher" => "some uuid_voucher", "level" => "0", "description" => "description"}
  @update_attrs3 %{"apply_third_party_to" => "y", "apply_to" => 43, "character" => false, "code" => "1-00-000-00000-0", "group_code" => 43, "is_departamental" => false, "name" => "Activo updated", "parent_account" => -1, "payment_method" => false, "root_account" => 43, "status" => "i", "third_party_op" => false, "third_party_prosecutor" => 43, "type" => "h", "uuid_voucher" => "111-111-111-1111", "level" => "0", "description" => "description"}
  @valid_struct_attrs2 %{"size" => 42, "max_current_size" => 0, "level" => 0}

  def fixture(:accounts) do
    AccountingSystem.StructureHandler.create_structure(@valid_struct_attrs2)
    {:ok, account} = AccountHandler.create_account(@valid_attrs3)
    account
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Accounts"
    end
  end

  describe "new account" do
    setup [:create_account]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :new))
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "create account" do
    test "redirects to show when data is valid", %{conn: conn} do
      AccountingSystem.StructureHandler.create_structure(@valid_struct_attrs2)
      conn = post(conn, Routes.account_path(conn, :create), account_code_schema: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.account_path(conn, :show, id)

      conn = get(conn, Routes.account_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Account"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      AccountingSystem.StructureHandler.create_structure(@valid_struct_attrs2)
      conn = post(conn, Routes.account_path(conn, :create), account_code_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "edit account" do
    setup [:create_account]

    test "renders form for editing chosen account", %{conn: conn, accounts: account} do
      conn = get(conn, Routes.account_path(conn, :edit, account))
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "update account" do
    setup [:create_account]

    test "redirects when data is valid", %{conn: conn, accounts: account} do
      conn = put(conn, Routes.account_path(conn, :update, account), account_schema: @update_attrs3)
      assert redirected_to(conn) == Routes.account_path(conn, :show, account)

      conn = get(conn, Routes.account_path(conn, :show, account))
      assert html_response(conn, 200) =~ "y"
    end

    test "renders errors when data is invalid", %{conn: conn, accounts: account} do
      conn = put(conn, Routes.account_path(conn, :update, account), account_schema: @invalid_attrs3)
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, accounts: account} do
      conn = delete(conn, Routes.account_path(conn, :delete, account))
      assert redirected_to(conn) == Routes.account_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.account_path(conn, :show, account))
      end
    end
  end

  defp create_account(_) do
    account = fixture(:accounts)
    {:ok, accounts: account}
  end
end
