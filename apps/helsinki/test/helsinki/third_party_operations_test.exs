defmodule AccountingSystem.ThirdPartyOperationsTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.ThirdPartyOperationsHandler

  describe "thirdpartyoperations" do
    alias AccountingSystem.ThirdPartyOperationSchema

    @valid_attrs %{account_number: "some account_number", policy_id: 42, provider_id: 42}
    @update_attrs %{account_number: "some updated account_number", policy_id: 43, provider_id: 43}
    @invalid_attrs %{account_number: nil, policy_id: nil, provider_id: nil}

    def third_party_operation_fixture(attrs \\ %{}) do
      {:ok, third_party_operation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ThirdPartyOperationsHandler.create_third_party_operation()

      third_party_operation
    end

    test "list_thirdpartyoperations/0 returns all thirdpartyoperations" do
      third_party_operation = third_party_operation_fixture()
      assert ThirdPartyOperationsHandler.list_thirdpartyoperations() == [third_party_operation]
    end

    test "get_third_party_operation!/1 returns the third_party_operation with given id" do
      third_party_operation = third_party_operation_fixture()
      assert ThirdPartyOperationsHandler.get_third_party_operation!(third_party_operation.id) == third_party_operation
    end

    test "create_third_party_operation/1 with valid data creates a third_party_operation" do
      assert {:ok, %ThirdPartyOperationSchema{} = third_party_operation} = ThirdPartyOperationsHandler.create_third_party_operation(@valid_attrs)
      assert third_party_operation.account_number == "some account_number"
      assert third_party_operation.policy_id == 42
      assert third_party_operation.provider_id == 42
    end

    test "create_third_party_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ThirdPartyOperationsHandler.create_third_party_operation(@invalid_attrs)
    end

    test "update_third_party_operation/2 with valid data updates the third_party_operation" do
      third_party_operation = third_party_operation_fixture()
      assert {:ok, %ThirdPartyOperationSchema{} = third_party_operation} = ThirdPartyOperationsHandler.update_third_party_operation(third_party_operation, @update_attrs)
      assert third_party_operation.account_number == "some updated account_number"
      assert third_party_operation.policy_id == 43
      assert third_party_operation.provider_id == 43
    end

    test "update_third_party_operation/2 with invalid data returns error changeset" do
      third_party_operation = third_party_operation_fixture()
      assert {:error, %Ecto.Changeset{}} = ThirdPartyOperationsHandler.update_third_party_operation(third_party_operation, @invalid_attrs)
      assert third_party_operation == ThirdPartyOperationsHandler.get_third_party_operation!(third_party_operation.id)
    end

    test "delete_third_party_operation/1 deletes the third_party_operation" do
      third_party_operation = third_party_operation_fixture()
      assert {:ok, %ThirdPartyOperationSchema{}} = ThirdPartyOperationsHandler.delete_third_party_operation(third_party_operation)
      assert_raise Ecto.NoResultsError, fn -> ThirdPartyOperationsHandler.get_third_party_operation!(third_party_operation.id) end
    end

    test "change_third_party_operation/1 returns a third_party_operation changeset" do
      third_party_operation = third_party_operation_fixture()
      assert %Ecto.Changeset{} = ThirdPartyOperationsHandler.change_third_party_operation(third_party_operation)
    end
  end
end
