defmodule AccountingSystem.StructuresTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.StructureHandler

  describe "structures" do
    alias AccountingSystem.StructureSchema

    @update_attrs %{size: 43, max_current_size: 43, level: 0}
    @invalid_attrs %{size: nil, max_current_size: nil, level: 0}
    @invalid_attrs2 %{"size" => nil, "max_current_size" => nil, "level" => 0}
    @valid_attrs2 %{"size" => 1, "max_current_size" => 0, "level" => 0}

    def structure_fixture(attrs \\ %{}) do
      {:ok, structure} =
        attrs
        |> Enum.into(@valid_attrs2)
        |> StructureHandler.create_structure()

      structure
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
      assert structure.size == 1
      assert structure.level == 0
      assert structure.max_current_size == 0
    end

    test "create_structure/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StructureHandler.create_structure(@invalid_attrs2)
    end

    test "update_structure/2 with valid data updates the structure" do
      structure = structure_fixture()
      assert {:ok, %StructureSchema{} = structure} = StructureHandler.update_structure(structure, @update_attrs)
      assert structure.size == 43
      assert structure.level == 0
      assert structure.max_current_size == 43
    end

    test "update_structure/2 with invalid data returns error changeset" do
      structure = structure_fixture()
      assert {:error, %Ecto.Changeset{}} = StructureHandler.update_structure(structure, @invalid_attrs)
      assert structure == StructureHandler.get_structure!(structure.id)
    end

    test "delete_structure/1 deletes the structure" do
      structure = structure_fixture()
      assert {:ok} = StructureHandler.delete_structure(structure)
      assert_raise Ecto.NoResultsError, fn -> StructureHandler.get_structure!(structure.id) end
    end

    test "change_structure/1 returns a structure changeset" do
      structure = structure_fixture()
      assert %Ecto.Changeset{} = StructureHandler.change_structure(structure)
    end
  end
end
