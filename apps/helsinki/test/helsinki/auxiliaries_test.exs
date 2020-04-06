defmodule AccountingSystem.AuxiliariesTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.{
    AccountHandler,
    AuxiliaryHandler,
    PolicyHandler,
    PolicyTipeHandler,
    StructureHandler
  }

  describe "auxiliaries" do
    alias AccountingSystem.AuxiliarySchema

    @valid_aux_attrs %{policy_number: 1, id_account: 1, concept: "some concept", debit_credit: "D", mxn_amount: 120.5, amount: 120.5, department: 1, counterpart: "some counterpart", cost_center: 1, group: 1, iduuid: 1, exchange_rate: 1, policy_id: 1, xml_id: nil, xml_name: "", xml_b64: nil}
    @valid_policy_attrs %{serial: "G", policy_number: 1, policy_type: 1, period: 4, fiscal_exercise: 2020, policy_date: Date.utc_today(), concept: "policy concept", audited: false, has_documents: false, status: true}
    @valid_account_attrs %{"apply_third_party_to" => "no", "apply_to" => 42, "character" => false, "code" => "2-001-001-002", "group_code" => 42, "is_departamental" => false, "name" => "Activos", "parent_account" => -1, "payment_method" => true, "root_account" => 1, "status" => "A", "third_party_op" => true, "third_party_prosecutor" => 42, "type" => "D", "uuid_voucher" => "some uuid_voucher", "level" => "3", "description" => "description", "rfc_literals" => "AAA", "rfc_numeric" => "010101", "rfc_key" => "000", "requires_xml" => false}
    @valid_structure %{"size" => "3", "max_current_size" => 0, "level" => 3}
    @valid_policy_type_attrs %{identifier: "G", name: "Gastos", classat: 1}
    @update_attrs %{concept: "other concept", mxn_amount: 150, amount: 150, department: 2, xml_id: nil, xml_name: "", xml_b64: nil}
    @invalid_attrs %{policy_number: nil, id_account: nil, concept: nil, debit_credit: nil, mxn_amount: 120.5, amount: 120.5, department: 1, counterpart: "some counterpart", cost_center: 1, group: 1, iduuid: 1, exchange_rate: 1, policy_id: 1, xml_id: nil, xml_name: "", xml_b64: nil}
    @valid_parmas %{"account" => "3-001-000-000", "aux_concept" => "xxx", "credit" => "0", "debit" => "0", "department" => "1", "id_account" => "170", "id_aux" => "", "name" => "Capital Social", "req_xml" => "false", "xml_b64" => "", "xml_id" => "", "xml_name" => "", "xml_name_file" => ""}
    @valid_year 2020
    @valid_month 4

    def auxiliary_fixture(attrs \\ %{}) do
      policy = policy_fixture()
      account = account_fixture()
        attrs
        |> Enum.into(@valid_aux_attrs)
        |> Map.put(:policy_id, policy.id)
        |> Map.put(:id_account, account.id)
        |> AuxiliaryHandler.create_auxiliary()
    end

    def auxiliary_fixture(attrs \\ %{}, year, month) do
      policy = policy_fixture()
      account = account_fixture()
        attrs
        |> Enum.into(@valid_aux_attrs)
        |> Map.put(:policy_id, policy.id)
        |> Map.put(:id_account, account.id)
        |> AuxiliaryHandler.create_auxiliary(year, month)
    end

    def policy_fixture(attrs \\ %{}) do
      policy_type = policy_type_fixture()
      {:ok, policy} =
        attrs
        |> Enum.into(@valid_policy_attrs)
        |> Map.put(:policy_type, policy_type.id)
        |> PolicyHandler.create_policy()
      policy
    end

    def account_fixture(attrs \\ %{}) do
      structure_fixture()
      {:ok, account} =
        attrs
        |> Enum.into(@valid_account_attrs)
        |> AccountHandler.create_account()
      account
    end

    def structure_fixture(attrs \\ %{}) do
      {:ok, structure} =
        attrs
        |> Enum.into(@valid_structure)
        |> StructureHandler.create_structure()
      structure
    end

    def policy_type_fixture(attrs \\ %{}) do
      {:ok, policy_type} =
        attrs
        |> Enum.into(@valid_policy_type_attrs)
        |> PolicyTipeHandler.create_policy_type()
      policy_type
    end

    test "list_auxiliaries/0 returns all auxiliaries" do
      auxiliary = auxiliary_fixture()
      assert AuxiliaryHandler.list_auxiliaries() == [auxiliary]
    end

    test "list_auxiliaries/2 returns all auxiliaries from specific period" do
      auxiliary = auxiliary_fixture(@valid_year, @valid_month)
      assert AuxiliaryHandler.list_auxiliaries(@valid_year, @valid_month) == [auxiliary]
    end

    test "get_aux_report/2 returns a list with accounts and their related auxiliaries from a specific period" do
      auxiliary = auxiliary_fixture()
      policy = PolicyHandler.get_policy!(auxiliary.policy_id)
      result =
        AuxiliaryHandler.get_aux_report(policy.policy_date, policy.policy_date)
        |> List.first()
        |> Map.get(:details)
        |> List.first()
      assert result.amount == auxiliary.amount
      assert result.auxiliary_type == auxiliary.debit_credit
      assert result.concept == auxiliary.concept
      assert result.number == auxiliary.policy_number
    end

    test "get_aux_report/4 returns a list with accounts and their related auxiliaries from a specific period and range of accounts" do
      auxiliary = auxiliary_fixture()
      policy = PolicyHandler.get_policy!(auxiliary.policy_id)
      initial_account = "1-001-001-001"
      final_account = "2-001-002-002"
      result =
        AuxiliaryHandler.get_aux_report(policy.policy_date, policy.policy_date, initial_account, final_account)
        |> List.first()
        |> Map.get(:details)
        |> List.first()
      assert result.amount == auxiliary.amount
      assert result.auxiliary_type == auxiliary.debit_credit
      assert result.concept == auxiliary.concept
      assert result.number == auxiliary.policy_number
    end

    test "get_auxiliary!/1 returns the auxiliary with given id" do
      auxiliary = auxiliary_fixture()
      assert AuxiliaryHandler.get_auxiliary!(auxiliary.id) == auxiliary
    end

    test "get_auxiliary!/3 returns the auxiliary with given id and specific period" do
      auxiliary = auxiliary_fixture(@valid_year, @valid_month)
      assert AuxiliaryHandler.get_auxiliary!(auxiliary.id, @valid_year, @valid_month) ==
      auxiliary
    end

    test "get_auxiliary_by_policy_id/1 returns a list with auxiliaries related with an specific policy_id" do
      auxiliary = auxiliary_fixture()
      result = List.first(AuxiliaryHandler.get_auxiliary_by_policy_id(auxiliary.policy_id))
      assert result.amount == auxiliary.amount
      assert result.number == auxiliary.policy_number
      assert result.policy_id == auxiliary.policy_id
      assert result.id == auxiliary.id
    end

    test "create_auxiliary/1 with valid data creates a auxiliary" do
      policy = policy_fixture()
      account = account_fixture()
      auxiliary =
      %{}
      |> Enum.into(@valid_aux_attrs)
      |> Map.put(:policy_id, policy.id)
      |> Map.put(:id_account, account.id)
      |> AuxiliaryHandler.create_auxiliary()
      assert auxiliary.amount == 120.5
      assert auxiliary.concept == "some concept"
      assert auxiliary.cost_center == nil
      assert auxiliary.counterpart == nil
      assert auxiliary.debit_credit == "D"
      assert auxiliary.department == 1
      assert auxiliary.exchange_rate == 1
      assert auxiliary.group == nil
      assert auxiliary.mxn_amount == 120.5
    end

    test "create_auxiliary/3 with valid data creates a auxiliary with specific period" do
      policy = policy_fixture()
      account = account_fixture()
      auxiliary =
      %{}
      |> Enum.into(@valid_aux_attrs)
      |> Map.put(:policy_id, policy.id)
      |> Map.put(:id_account, account.id)
      |> AuxiliaryHandler.create_auxiliary(@valid_year, @valid_month)
      assert auxiliary.amount == 120.5
      assert auxiliary.concept == "some concept"
      assert auxiliary.cost_center == nil
      assert auxiliary.counterpart == nil
      assert auxiliary.debit_credit == "D"
      assert auxiliary.department == 1
      assert auxiliary.exchange_rate == 1
      assert auxiliary.group == nil
      assert auxiliary.mxn_amount == 120.5
    end

    test "create_auxiliary/1 with invalid data returns error changeset" do
      assert %Ecto.Changeset{} = AuxiliaryHandler.create_auxiliary(@invalid_attrs)
    end

    test "update_auxiliary/2 with valid data updates the auxiliary" do
      auxiliary = auxiliary_fixture()
      auxiliary = AuxiliaryHandler.update_auxiliary(auxiliary, @update_attrs)
      assert auxiliary.amount == 150
      assert auxiliary.concept == "other concept"
      assert auxiliary.mxn_amount == 150
      assert auxiliary.department == 2
    end

    test "update_auxiliary/4 with valid data updates the auxiliary with specific period" do
      auxiliary = auxiliary_fixture(@valid_year, @valid_month)
      auxiliary = AuxiliaryHandler.update_auxiliary(auxiliary, @update_attrs, @valid_year, @valid_month)
      assert auxiliary.amount == 150
      assert auxiliary.concept == "other concept"
      assert auxiliary.mxn_amount == 150
      assert auxiliary.department == 2
    end

    test "update_auxiliary/2 with invalid data returns error changeset" do
      auxiliary = auxiliary_fixture()
      assert %Ecto.Changeset{} = AuxiliaryHandler.update_auxiliary(auxiliary, @invalid_attrs)
      assert auxiliary == AuxiliaryHandler.get_auxiliary!(auxiliary.id)
    end

    test "delete_auxiliary/1 deletes the auxiliary" do
      auxiliary = auxiliary_fixture()
      assert {:ok, %AuxiliarySchema{}} = AuxiliaryHandler.delete_auxiliary(auxiliary)
      assert_raise Ecto.NoResultsError, fn -> AuxiliaryHandler.get_auxiliary!(auxiliary.id) end
    end

    test "delete_auxiliary/3 deletes the auxiliary from specific period" do
      auxiliary = auxiliary_fixture(@valid_year, @valid_month)
      assert {:ok, %AuxiliarySchema{}} =
      AuxiliaryHandler.delete_auxiliary(auxiliary, @valid_year, @valid_month)
      assert_raise Ecto.NoResultsError,
      fn -> AuxiliaryHandler.get_auxiliary!(auxiliary.id, @valid_year, @valid_month) end
    end

    test "change_auxiliary/1 returns a auxiliary changeset" do
      auxiliary = auxiliary_fixture()
      assert %Ecto.Changeset{} = AuxiliaryHandler.change_auxiliary(auxiliary)
    end

    test "validate_auxiliar/1 validate if tha auxiliary map is complete" do
      {response, _params} = AuxiliaryHandler.validate_auxiliar(@valid_parmas)
      assert response == :ok
    end
  end
end
