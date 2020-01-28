defmodule AccountingSystem.StructuresTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.Structures

  describe "structures" do
    alias AccountingSystem.Structures.Structure

    @valid_attrs %{length: 42, max: 42, order: 42}
    @update_attrs %{length: 43, max: 43, order: 43}
    @invalid_attrs %{length: nil, max: nil, order: nil}

    def structure_fixture(attrs \\ %{}) do
      {:ok, structure} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Structures.create_structure()

      structure
    end

    test "list_structures/0 returns all structures" do
      structure = structure_fixture()
      assert Structures.list_structures() == [structure]
    end

    test "get_structure!/1 returns the structure with given id" do
      structure = structure_fixture()
      assert Structures.get_structure!(structure.id) == structure
    end

    test "create_structure/1 with valid data creates a structure" do
      assert {:ok, %Structure{} = structure} = Structures.create_structure(@valid_attrs)
      assert structure.length == 42
      assert structure.max == 42
      assert structure.order == 42
    end

    test "create_structure/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Structures.create_structure(@invalid_attrs)
    end

    test "update_structure/2 with valid data updates the structure" do
      structure = structure_fixture()
      assert {:ok, %Structure{} = structure} = Structures.update_structure(structure, @update_attrs)
      assert structure.length == 43
      assert structure.max == 43
      assert structure.order == 43
    end

    test "update_structure/2 with invalid data returns error changeset" do
      structure = structure_fixture()
      assert {:error, %Ecto.Changeset{}} = Structures.update_structure(structure, @invalid_attrs)
      assert structure == Structures.get_structure!(structure.id)
    end

    test "delete_structure/1 deletes the structure" do
      structure = structure_fixture()
      assert {:ok, %Structure{}} = Structures.delete_structure(structure)
      assert_raise Ecto.NoResultsError, fn -> Structures.get_structure!(structure.id) end
    end

    test "change_structure/1 returns a structure changeset" do
      structure = structure_fixture()
      assert %Ecto.Changeset{} = Structures.change_structure(structure)
    end
  end
end
