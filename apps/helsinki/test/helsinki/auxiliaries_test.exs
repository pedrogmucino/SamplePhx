defmodule AccountingSystem.AuxiliariesTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.AuxiliaryHandler

  describe "auxiliaries" do
    alias AccountingSystem.AuxiliarySchema

    @valid_attrs %{amount: 120.5, concept: "some concept", cost_center: 42, counterpart: "some counterpart", debit_credit: "some debit_credit", department: 42, exchange_rate: 120.5, group: 42, id_account: 42, iduuid: 42, mxn_amount: 120.5, policy_number: 42}
    @update_attrs %{amount: 456.7, concept: "some updated concept", cost_center: 43, counterpart: "some updated counterpart", debit_credit: "some updated debit_credit", department: 43, exchange_rate: 456.7, group: 43, id_account: 43, iduuid: 43, mxn_amount: 456.7, policy_number: 43}
    @invalid_attrs %{amount: nil, concept: nil, cost_center: nil, counterpart: nil, debit_credit: nil, department: nil, exchange_rate: nil, group: nil, id_account: nil, iduuid: nil, mxn_amount: nil, policy_number: nil}

    def auxiliary_fixture(attrs \\ %{}) do
      {:ok, auxiliary} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AuxiliaryHandler.create_auxiliary()

      auxiliary
    end

    test "list_auxiliaries/0 returns all auxiliaries" do
      auxiliary = auxiliary_fixture()
      assert AuxiliaryHandler.list_auxiliaries() == [auxiliary]
    end

    test "get_auxiliary!/1 returns the auxiliary with given id" do
      auxiliary = auxiliary_fixture()
      assert AuxiliaryHandler.get_auxiliary!(auxiliary.id) == auxiliary
    end

    test "create_auxiliary/1 with valid data creates a auxiliary" do
      assert {:ok, %AuxiliarySchema{} = auxiliary} = AuxiliaryHandler.create_auxiliary(@valid_attrs)
      assert auxiliary.amount == 120.5
      assert auxiliary.concept == "some concept"
      assert auxiliary.cost_center == 42
      assert auxiliary.counterpart == "some counterpart"
      assert auxiliary.debit_credit == "some debit_credit"
      assert auxiliary.department == 42
      assert auxiliary.exchange_rate == 120.5
      assert auxiliary.group == 42
      assert auxiliary.id_account == 42
      assert auxiliary.iduuid == 42
      assert auxiliary.mxn_amount == 120.5
      assert auxiliary.policy_number == 42
    end

    test "create_auxiliary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AuxiliaryHandler.create_auxiliary(@invalid_attrs)
    end

    test "update_auxiliary/2 with valid data updates the auxiliary" do
      auxiliary = auxiliary_fixture()
      assert {:ok, %AuxiliarySchema{} = auxiliary} = AuxiliaryHandler.update_auxiliary(auxiliary, @update_attrs)
      assert auxiliary.amount == 456.7
      assert auxiliary.concept == "some updated concept"
      assert auxiliary.cost_center == 43
      assert auxiliary.counterpart == "some updated counterpart"
      assert auxiliary.debit_credit == "some updated debit_credit"
      assert auxiliary.department == 43
      assert auxiliary.exchange_rate == 456.7
      assert auxiliary.group == 43
      assert auxiliary.id_account == 43
      assert auxiliary.iduuid == 43
      assert auxiliary.mxn_amount == 456.7
      assert auxiliary.policy_number == 43
    end

    test "update_auxiliary/2 with invalid data returns error changeset" do
      auxiliary = auxiliary_fixture()
      assert {:error, %Ecto.Changeset{}} = AuxiliaryHandler.update_auxiliary(auxiliary, @invalid_attrs)
      assert auxiliary == AuxiliaryHandler.get_auxiliary!(auxiliary.id)
    end

    test "delete_auxiliary/1 deletes the auxiliary" do
      auxiliary = auxiliary_fixture()
      assert {:ok, %Auxiliary{}} = AuxiliaryHandler.delete_auxiliary(auxiliary)
      assert_raise Ecto.NoResultsError, fn -> AuxiliaryHandler.get_auxiliary!(auxiliary.id) end
    end

    test "change_auxiliary/1 returns a auxiliary changeset" do
      auxiliary = auxiliary_fixture()
      assert %Ecto.Changeset{} = AuxiliaryHandler.change_auxiliary(auxiliary)
    end
  end
end
