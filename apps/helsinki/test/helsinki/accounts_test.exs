defmodule AccountingSystem.AccountsTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.Accounts

  describe "accounts" do
    alias AccountingSystem.Accounts.Account

    @valid_attrs %{apply_third_party_to: "some apply_third_party_to", apply_to: 42, character: true, code: "some code", group_code: 42, is_departamental: true, name: "some name", parent_account: 42, payment_method: true, root_account: 42, status: "some status", third_party_op: true, third_party_prosecutor: 42, type: "some type", uuid_voucher: "some uuid_voucher"}
    @update_attrs %{apply_third_party_to: "some updated apply_third_party_to", apply_to: 43, character: false, code: "some updated code", group_code: 43, is_departamental: false, name: "some updated name", parent_account: 43, payment_method: false, root_account: 43, status: "some updated status", third_party_op: false, third_party_prosecutor: 43, type: "some updated type", uuid_voucher: "some updated uuid_voucher"}
    @invalid_attrs %{apply_third_party_to: nil, apply_to: nil, character: nil, code: nil, group_code: nil, is_departamental: nil, name: nil, parent_account: nil, payment_method: nil, root_account: nil, status: nil, third_party_op: nil, third_party_prosecutor: nil, type: nil, uuid_voucher: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Accounts.create_account(@valid_attrs)
      assert account.apply_third_party_to == "some apply_third_party_to"
      assert account.apply_to == 42
      assert account.character == true
      assert account.code == "some code"
      assert account.group_code == 42
      assert account.is_departamental == true
      assert account.name == "some name"
      assert account.parent_account == 42
      assert account.payment_method == true
      assert account.root_account == 42
      assert account.status == "some status"
      assert account.third_party_op == true
      assert account.third_party_prosecutor == 42
      assert account.type == "some type"
      assert account.uuid_voucher == "some uuid_voucher"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Accounts.update_account(account, @update_attrs)
      assert account.apply_third_party_to == "some updated apply_third_party_to"
      assert account.apply_to == 43
      assert account.character == false
      assert account.code == "some updated code"
      assert account.group_code == 43
      assert account.is_departamental == false
      assert account.name == "some updated name"
      assert account.parent_account == 43
      assert account.payment_method == false
      assert account.root_account == 43
      assert account.status == "some updated status"
      assert account.third_party_op == false
      assert account.third_party_prosecutor == 43
      assert account.type == "some updated type"
      assert account.uuid_voucher == "some updated uuid_voucher"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
