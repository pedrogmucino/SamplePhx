defmodule AccountingSystem.StructuresTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.StructureHandler
  alias AccountingSystem.AccountHandler

  describe "structures" do
    alias AccountingSystem.StructureSchema

    @update_attrs %{size: 1, max_current_size: 1, level: 0}
    @invalid_attrs %{size: nil, max_current_size: nil, level: 0}
    @invalid_attrs2 %{"size" => nil, "max_current_size" => nil, "level" => 0}
    @valid_attrs %{size: 2, max_current_size: 1, level: 1}
    @valid_attrs_lvl1 %{"size" => 2, "max_current_size" => 0, "level" => 1}
    @valid_attrs2 %{"size" => 2, "max_current_size" => 0, "level" => 0}

    @valid_account %{"apply_third_party_to" => "no", "apply_to" => 42, "character" => false, "code" => "01-00", "group_code" => 42, "is_departamental" => false, "name" => "Activos", "parent_account" => -1, "payment_method" => true, "root_account" => 1, "status" => "a", "third_party_op" => true, "third_party_prosecutor" => 42, "type" => "d", "uuid_voucher" => "some uuid_voucher", "level" => "0", "description" => "description"}
    @valid_account_child %{"apply_third_party_to" => "no", "apply_to" => 42, "character" => false, "code" => "01-01", "group_code" => 42, "is_departamental" => false, "name" => "Circulante", "parent_account" => 1, "payment_method" => true, "root_account" => 1, "status" => "a", "third_party_op" => true, "third_party_prosecutor" => 42, "type" => "d", "uuid_voucher" => "some uuid_voucher", "level" => "1", "description" => "description"}

    def structure_fixture(attrs \\ %{}) do
      {:ok, structure} =
        attrs
        |> Enum.into(@valid_attrs2)
        |> StructureHandler.create_structure()

      structure
    end

    test "new_structure/1 when recives a nil as a parametter returns level 0 and max_current 0" do
      assert structure = %StructureSchema{} = StructureHandler.new_structure(nil)
      assert structure.level == 0
      assert structure.max_current_size == 0
    end

    test "new_structure/1 when recives a struct as a parametter returns a structure demi-filled" do
      assert structure = %StructureSchema{} = StructureHandler.new_structure(@valid_attrs)
      assert structure.level == structure.level
      assert structure.max_current_size == 0
    end

    test "update_code_size/2 add zeros to accounts when it changes" do
      struct = structure_fixture()
      StructureHandler.create_structure(@valid_attrs_lvl1)
      AccountHandler.create_account(@valid_account)
      AccountHandler.create_account(@valid_account_child)
      assert {:error} != StructureHandler.update_code_size(struct, %{"size" => "3"})
    end

    test "update_code_size/2 Quit zeros to accounts when it changes" do
      struct = structure_fixture()
      StructureHandler.create_structure(@valid_attrs_lvl1)
      AccountHandler.create_account(@valid_account)
      AccountHandler.create_account(@valid_account_child)
      assert {:error} != StructureHandler.update_code_size(struct, %{"size" => "1"})
    end

    test "update_code_size/2 returns error when new size is < than max_current_size" do
      struct = structure_fixture()
      assert {:error} == StructureHandler.update_code_size(struct, %{"size" => "-1"})
    end

    test "list_structures/0 returns all structures" do
      structure = structure_fixture()
      assert StructureHandler.list_structures() == [structure]
    end

    test "get_structure!/1 returns the structure with given id" do
      structure = structure_fixture()
      assert StructureHandler.get_structure!(structure.id) == structure
    end

    test "create_structure/1 with valid data creates a structure" do
      assert {:ok, %StructureSchema{} = structure} = StructureHandler.create_structure(@valid_attrs2)
      assert structure.size == 2
      assert structure.level == 0
      assert structure.max_current_size == 0
    end

    test "create_structure/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StructureHandler.create_structure(@invalid_attrs2)
    end

    test "update_structure/2 with valid data updates the structure" do
      structure = structure_fixture()
      assert {:ok, %StructureSchema{} = structure} = StructureHandler.update_structure(structure, @update_attrs)
      assert structure.size == 1
      assert structure.level == 0
      assert structure.max_current_size == 1
    end

    test "update_structure/2 with invalid data returns error changeset" do
      structure = structure_fixture()
      assert {:error, %Ecto.Changeset{}} = StructureHandler.update_structure(structure, @invalid_attrs)
      assert structure == StructureHandler.get_structure!(structure.id)
    end

    test "delete_structure/1 deletes the structure" do
      structure_fixture()
      {:ok, %StructureSchema{} = structure} = StructureHandler.create_structure(@valid_attrs_lvl1)
      AccountHandler.create_account(@valid_account)
      assert {:ok} = StructureHandler.delete_structure(structure)
      assert_raise Ecto.NoResultsError, fn -> StructureHandler.get_structure!(structure.id) end
    end

    test "delete_structure/1 returns error when exist an account" do
      structure_id = structure_fixture()
      AccountHandler.create_account(@valid_account)
      structure = StructureHandler.get_structure!(structure_id.id)
      assert {:error} = StructureHandler.delete_structure(structure)
    end

    test "change_structure/1 returns a structure changeset" do
      structure = structure_fixture()
      assert %Ecto.Changeset{} = StructureHandler.change_structure(structure)
    end
  end
end
