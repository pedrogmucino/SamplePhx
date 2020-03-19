defmodule AccountingSystem.PolicyTypesTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.PolicyTypeHandler

  describe "policytypes" do
    alias AccountingSystem.PolicyTypeSchema

    @valid_attrs %{identifier: "some identifier", name: "some name", classat: 1}
    @update_attrs %{identifier: "some updated identifier", name: "some updated name", classat: 2}
    @invalid_attrs %{identifier: nil, name: nil, classat: nil}

    def policy_type_fixture(attrs \\ %{}) do
      {:ok, policy_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PolicyTypeHandler.create_policy_type()

      policy_type
    end

    test "list_policytypes/0 returns all policytypes" do
      policy_type = policy_type_fixture()
      assert PolicyTypeHandler.list_policytypes() == [policy_type]
    end

    test "get_policy_type!/1 returns the policy_type with given id" do
      policy_type = policy_type_fixture()
      assert PolicyTypeHandler.get_policy_type!(policy_type.id) == policy_type
    end

    test "create_policy_type/1 with valid data creates a policy_type" do
      assert {:ok, %PolicyTypeSchema{} = policy_type} = PolicyTypeHandler.create_policy_type(@valid_attrs)
      assert policy_type.identifier == "some identifier"
      assert policy_type.name == "some name"
    end

    test "create_policy_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PolicyTypeHandler.create_policy_type(@invalid_attrs)
    end

    test "update_policy_type/2 with valid data updates the policy_type" do
      policy_type = policy_type_fixture()
      assert {:ok, %PolicyTypeSchema{} = policy_type} = PolicyTypeHandler.update_policy_type(policy_type, @update_attrs)
      assert policy_type.identifier == "some updated identifier"
      assert policy_type.name == "some updated name"
    end

    test "update_policy_type/2 with invalid data returns error changeset" do
      policy_type = policy_type_fixture()
      assert {:error, %Ecto.Changeset{}} = PolicyTypeHandler.update_policy_type(policy_type, @invalid_attrs)
      assert policy_type == PolicyTypeHandler.get_policy_type!(policy_type.id)
    end

    test "delete_policy_type/1 deletes the policy_type" do
      policy_type = policy_type_fixture()
      assert {:ok, %PolicyTypeSchema{}} = PolicyTypeHandler.delete_policy_type(policy_type)
      assert_raise Ecto.NoResultsError, fn -> PolicyTypeHandler.get_policy_type!(policy_type.id) end
    end

    test "change_policy_type/1 returns a policy_type changeset" do
      policy_type = policy_type_fixture()
      assert %Ecto.Changeset{} = PolicyTypeHandler.change_policy_type(policy_type)
    end
  end
end
