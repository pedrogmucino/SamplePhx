defmodule AccountingSystem.AccountsTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.AccountHandler

  describe "accounts" do
    alias AccountingSystem.AccountSchema
    alias AccountingSystem.AccountCodeSchema

    @invalid_attrs3 %{"apply_third_party_to" => nil, "apply_to" => nil, "character" => nil, "code" => "1", "group_code" => nil, "is_departamental" => nil, "name" => nil, "parent_account" => nil, "payment_method" => nil, "root_account" => nil, "status" => nil, "third_party_op" => nil, "third_party_prosecutor" => nil, "type" => nil, "uuid_voucher" => nil, "level" => "0"}
    @valid_attrs3 %{"apply_third_party_to" => "no", "apply_to" => 42, "character" => false, "code" => "1-000-00-00000-000", "group_code" => 42, "is_departamental" => false, "name" => "Activos", "parent_account" => -1, "payment_method" => true, "root_account" => 1, "status" => "a", "third_party_op" => true, "third_party_prosecutor" => 42, "type" => "d", "uuid_voucher" => "some uuid_voucher", "level" => "0", "description" => "description"}
    @valid_attrs_same_level %{"apply_third_party_to" => "no", "apply_to" => 42, "character" => false, "code" => "1-010-00-00000-000", "group_code" => 42, "is_departamental" => false, "name" => "Activos", "parent_account" => -1, "payment_method" => true, "root_account" => 1, "status" => "a", "third_party_op" => true, "third_party_prosecutor" => 42, "type" => "d", "uuid_voucher" => "some uuid_voucher", "level" => "0", "description" => "description"}
    @update_attrs3 %{"apply_third_party_to" => "y", "apply_to" => 43, "character" => false, "code" => "1-00-000-00000-0", "group_code" => 43, "is_departamental" => false, "name" => "Activo updated", "parent_account" => -1, "payment_method" => false, "root_account" => 43, "status" => "i", "third_party_op" => false, "third_party_prosecutor" => 43, "type" => "h", "uuid_voucher" => "111-111-111-1111", "level" => "0", "description" => "description"}
    @valid_struct_attrs2 %{"size" => 1, "max_current_size" => 0, "level" => 0}
    @valid_child %{"apply_third_party_to" => "no", "apply_to" => 42, "character" => false, "code" => "1-001-00-00000-000", "group_code" => 42, "is_departamental" => false, "name" => "Circulante", "parent_account" => 1, "payment_method" => true, "root_account" => 1, "status" => "a", "third_party_op" => true, "third_party_prosecutor" => 42, "type" => "d", "uuid_voucher" => "some uuid_voucher", "level" => "1", "description" => "description"}
    @structure_lvl2 %{"size" => "3", "max_current_size" => 0, "level" => 1}

    def account_fixture2(attrs \\ %{}) do
      AccountingSystem.StructureHandler.create_structure(@valid_struct_attrs2)
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs3)
        |> AccountHandler.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture2()
      assert AccountHandler.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture2()
      assert AccountHandler.get_account!(account.id) == account
    end

    test "get_account_code!/1 returns a reduced information from account given id" do
      account = account_fixture2()
      assert the_account = %AccountCodeSchema{} = AccountHandler.get_account_code!(account.id)
      assert the_account.code == "1-000-00-00000-000"
      assert the_account.level == 0
      assert the_account.root_account == 1
      assert the_account.parent_account == -1
    end

    test "get_principal_account!/0 returns the first account (in Account Code Schema Format) ordered by id" do
      account_fixture2()
      assert the_account = %AccountCodeSchema{} = AccountHandler.get_principal_account!()
      assert the_account.code == "1-000-00-00000-000"
      assert the_account.level == 0
      assert the_account.root_account == 1
      assert the_account.parent_account == -1
    end

    test "get_last_child/1 returns the last child account given the father's id" do
      account = account_fixture2()
      %{id: id} = AccountingSystem.GetSetAccountsCodes.get_code_and_id()
          |> List.first
      AccountingSystem.StructureHandler.create_structure(@structure_lvl2)
      Map.put(@valid_child, "parent_account", id)
        |> AccountHandler.create_account()
      assert [%{code: code}] = AccountHandler.get_last_child(account.id)
      assert code = "1-001-00-00000-000"
    end

    test "create_account/1 with valid data creates a account" do
      AccountingSystem.StructureHandler.create_structure(@valid_struct_attrs2)
      assert {:ok, %AccountSchema{} = account} = AccountHandler.create_account(@valid_attrs3)
      assert account.apply_third_party_to == "no"
      assert account.apply_to == 42
      assert account.character == false
      assert account.code == "1-000-00-00000-000"
      assert account.group_code == 42
      assert account.is_departamental == false
      assert account.name == "Activos"
      assert account.parent_account == -1
      assert account.payment_method == true
      assert account.root_account == 1
      assert account.status == "a"
      assert account.third_party_op == true
      assert account.third_party_prosecutor == 42
      assert account.type == "d"
      assert account.uuid_voucher == "some uuid_voucher"
      assert account.description == "description"
    end

    test "create_account/1 with invalid data returns error changeset" do
      AccountingSystem.StructureHandler.create_structure(@valid_struct_attrs2)
      assert {:error, %Ecto.Changeset{}} = AccountHandler.create_account(@invalid_attrs3)

    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture2()
      assert {:ok, %AccountSchema{} = account} = AccountHandler.update_account(account, @update_attrs3)
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
      assert account.description == "description"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture2()
      assert {:error, %Ecto.Changeset{}} = AccountHandler.update_account(account, @invalid_attrs3)
      assert account == AccountHandler.get_account!(account.id)
    end

    test "delete_account/1 deletes the account when exist two or more accounts at same level" do
      account_fixture2()
      assert {:ok, account_to_delete} = AccountHandler.create_account(@valid_attrs_same_level)
      assert {:ok, %{"code" => "1-010-00-00000-000", "level" => "0"}} = AccountHandler.delete_account(account_to_delete)
      assert_raise Ecto.NoResultsError, fn -> AccountHandler.get_account!(account_to_delete.id) end
    end

    test "delete_account/1 deletes the account when only exist one" do
      account = account_fixture2()
      assert {:ok, %AccountingSystem.StructureSchema{}} = AccountHandler.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> AccountHandler.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture2()
      assert %Ecto.Changeset{} = AccountHandler.change_account(account)
    end

    test "change_account_code/1 returns a account code changeset" do
      account = account_fixture2()
      codeschema = AccountHandler.get_account_code!(account.id)
      assert %Ecto.Changeset{} = AccountHandler.change_account_code(codeschema)
    end
  end
end
