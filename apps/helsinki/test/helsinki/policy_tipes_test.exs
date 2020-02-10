defmodule AccountingSystem.PolicyTipesTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.PolicyTipeHandler

  describe "policytypes" do
    alias AccountingSystem.PolicyTipeSchema

    @valid_attrs %{identifier: "some identifier", name: "some name", classat: 1}
    @update_attrs %{identifier: "some updated identifier", name: "some updated name", classat: 2}
    @invalid_attrs %{identifier: nil, name: nil, classat: nil}

    def policy_type_fixture(attrs \\ %{}) do
      {:ok, policy_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PolicyTipeHandler.create_policy_type()

      policy_type
    end

    test "list_policytypes/0 returns all policytypes" do
      policy_type = policy_type_fixture()
      assert PolicyTipeHandler.list_policytypes() == [policy_type]
    end

    test "get_policy_type!/1 returns the policy_type with given id" do
      policy_type = policy_type_fixture()
      assert PolicyTipeHandler.get_policy_type!(policy_type.id) == policy_type
    end

    test "create_policy_type/1 with valid data creates a policy_type" do
      assert {:ok, %PolicyTipeSchema{} = policy_type} = PolicyTipeHandler.create_policy_type(@valid_attrs)
      assert policy_type.identifier == "some identifier"
      assert policy_type.name == "some name"
    end

    test "create_policy_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PolicyTipeHandler.create_policy_type(@invalid_attrs)
    end

    test "update_policy_type/2 with valid data updates the policy_type" do
      policy_type = policy_type_fixture()
      assert {:ok, %PolicyTipeSchema{} = policy_type} = PolicyTipeHandler.update_policy_type(policy_type, @update_attrs)
      assert policy_type.identifier == "some updated identifier"
      assert policy_type.name == "some updated name"
    end

    test "update_policy_type/2 with invalid data returns error changeset" do
      policy_type = policy_type_fixture()
      assert {:error, %Ecto.Changeset{}} = PolicyTipeHandler.update_policy_type(policy_type, @invalid_attrs)
      assert policy_type == PolicyTipeHandler.get_policy_type!(policy_type.id)
    end

    test "delete_policy_type/1 deletes the policy_type" do
      policy_type = policy_type_fixture()
      assert {:ok, %PolicyTipeSchema{}} = PolicyTipeHandler.delete_policy_type(policy_type)
      assert_raise Ecto.NoResultsError, fn -> PolicyTipeHandler.get_policy_type!(policy_type.id) end
    end

    test "change_policy_type/1 returns a policy_type changeset" do
      policy_type = policy_type_fixture()
      assert %Ecto.Changeset{} = PolicyTipeHandler.change_policy_type(policy_type)
    end
  end
end
