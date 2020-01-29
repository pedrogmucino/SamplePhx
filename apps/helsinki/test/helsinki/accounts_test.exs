defmodule AccountingSystem.AccountsTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.AccountHandler

  describe "accounts" do
    alias AccountingSystem.AccountSchema

    @valid_attrs %{apply_third_party_to: "no", apply_to: 42, character: false, code: "1-000-00-00000-000", group_code: 42, is_departamental: false, name: "Activos", parent_account: 42, payment_method: true, root_account: 1, status: "a", third_party_op: true, third_party_prosecutor: 42, type: "d", uuid_voucher: "some uuid_voucher", level: 0}
    @update_attrs %{apply_third_party_to: "y", apply_to: 43, character: false, code: "1-00-000-00000-0", group_code: 43, is_departamental: false, name: "Activo updated", parent_account: -1, payment_method: false, root_account: 43, status: "i", third_party_op: false, third_party_prosecutor: 43, type: "h", uuid_voucher: "111-111-111-1111",level: 0}
    @invalid_attrs %{apply_third_party_to: nil, apply_to: nil, character: nil, code: nil, group_code: nil, is_departamental: nil, name: nil, parent_account: nil, payment_method: nil, root_account: nil, status: nil, third_party_op: nil, third_party_prosecutor: nil, type: nil, uuid_voucher: nil, level: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AccountHandler.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert AccountHandler.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert AccountHandler.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %AccountSchema{} = account} = AccountHandler.create_account(@valid_attrs)
      assert account.apply_third_party_to == "no"
      assert account.apply_to == 42
      assert account.character == false
      assert account.code == "1-000-00-00000-000"
      assert account.group_code == 42
      assert account.is_departamental == false
      assert account.name == "Activos"
      assert account.parent_account == 42
      assert account.payment_method == true
      assert account.root_account == 1
      assert account.status == "a"
      assert account.third_party_op == true
      assert account.third_party_prosecutor == 42
      assert account.type == "d"
      assert account.uuid_voucher == "some uuid_voucher"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountHandler.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %AccountSchema{} = account} = AccountHandler.update_account(account, @update_attrs)
      assert account.apply_third_party_to == "y"
      assert account.apply_to == 43
      assert account.character == false
      assert account.code == "1-00-000-00000-0"
      assert account.group_code == 43
      assert account.is_departamental == false
      assert account.name == "Activo updated"
      assert account.parent_account == -1
      assert account.payment_method == false
      assert account.root_account == 43
      assert account.status == "i"
      assert account.third_party_op == false
      assert account.third_party_prosecutor == 43
      assert account.type == "h"
      assert account.uuid_voucher == "111-111-111-1111"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = AccountHandler.update_account(account, @invalid_attrs)
      assert account == AccountHandler.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %AccountSchema{}} = AccountHandler.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> AccountHandler.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = AccountHandler.change_account(account)
    end
  end
end
