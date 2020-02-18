defmodule AccountingSystem.PoliciesTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.PolicyHandler

  describe "policies" do
    alias AccountingSystem.PolicySchema

    @valid_attrs %{audited: true, concept: "some concept", fiscal_exercise: 42, has_documents: true, period: 42, policy_date: ~D[2010-04-17], policy_number: 42, policy_type: 42}
    @update_attrs %{audited: false, concept: "some updated concept", fiscal_exercise: 43, has_documents: false, period: 43, policy_date: ~D[2011-05-18], policy_number: 43, policy_type: 43}
    @invalid_attrs %{audited: nil, concept: nil, fiscal_exercise: nil, has_documents: nil, period: nil, policy_date: nil, policy_number: nil, policy_type: nil}
    @valid_year 2020
    @valid_month 2

    def policy_fixture(attrs \\ %{}) do
      {:ok, policy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PolicyHandler.create_policy()

      policy
    end

    def policy_fixture(attrs \\ %{}, year, month) do
      {:ok, policy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PolicyHandler.create_policy(year, month)

      policy
    end

    test "list_policies/0 returns all policies" do
      policy = policy_fixture()
      assert PolicyHandler.list_policies() == [policy]
    end

    test "list_policies/2 returns all policies from a given period" do
      policy = policy_fixture(@valid_year, @valid_month)
      assert PolicyHandler.list_policies(@valid_year, @valid_month) == [policy]
    end

    test "get_policy!/1 returns the policy with given id" do
      policy = policy_fixture()
      assert PolicyHandler.get_policy!(policy.id) == policy
    end

    test "get_policy!/3 returns the policy with a given id and period" do
      policy = policy_fixture(@valid_year, @valid_month)
      assert PolicyHandler.get_policy!(policy.id, @valid_year, @valid_month) == policy
    end

    test "create_policy/1 with valid data creates a policy" do
      assert {:ok, %PolicySchema{} = policy} = PolicyHandler.create_policy(@valid_attrs)
      assert policy.audited == true
      assert policy.concept == "some concept"
      assert policy.fiscal_exercise == 42
      assert policy.has_documents == true
      assert policy.period == 42
      assert policy.policy_date == ~D[2010-04-17]
      assert policy.policy_number == 42
      assert policy.policy_type == 42
    end

    test "create_policy/3 with valid data creates a policy for specific period" do
      assert {:ok, %PolicySchema{} = policy} =
      PolicyHandler.create_policy(@valid_attrs, @valid_year, @valid_month)
      assert policy.audited == true
      assert policy.concept == "some concept"
      assert policy.fiscal_exercise == 42
      assert policy.has_documents == true
      assert policy.period == 42
      assert policy.policy_date == ~D[2010-04-17]
      assert policy.policy_number == 42
      assert policy.policy_type == 42
    end

    test "create_policy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PolicyHandler.create_policy(@invalid_attrs)
    end

    test "update_policy/2 with valid data updates the policy" do
      policy = policy_fixture()
      assert {:ok, %PolicySchema{} = policy} = PolicyHandler.update_policy(policy, @update_attrs)
      assert policy.audited == false
      assert policy.concept == "some updated concept"
      assert policy.fiscal_exercise == 43
      assert policy.has_documents == false
      assert policy.period == 43
      assert policy.policy_date == ~D[2011-05-18]
      assert policy.policy_number == 43
      assert policy.policy_type == 43
    end

    test "update_policy/4 with valid data updates the policy for a specific period" do
      policy = policy_fixture(@valid_year, @valid_month)
      assert {:ok, %PolicySchema{} = policy} =
      PolicyHandler.update_policy(policy, @update_attrs, @valid_year, @valid_month)
      assert policy.audited == false
      assert policy.concept == "some updated concept"
      assert policy.fiscal_exercise == 43
      assert policy.has_documents == false
      assert policy.period == 43
      assert policy.policy_date == ~D[2011-05-18]
      assert policy.policy_number == 43
      assert policy.policy_type == 43
    end

    test "update_policy/2 with invalid data returns error changeset" do
      policy = policy_fixture()
      assert {:error, %Ecto.Changeset{}} = PolicyHandler.update_policy(policy, @invalid_attrs)
      assert policy == PolicyHandler.get_policy!(policy.id)
    end

    test "delete_policy/1 deletes the policy" do
      policy = policy_fixture()
      assert {:ok, %PolicySchema{}} = PolicyHandler.delete_policy(policy)
      assert_raise Ecto.NoResultsError, fn -> PolicyHandler.get_policy!(policy.id) end
    end

    test "delete_policy/3 deletes the policy from a specific period" do
      policy = policy_fixture(@valid_year, @valid_month)
      assert {:ok, %PolicySchema{}} =
      PolicyHandler.delete_policy(policy, @valid_year, @valid_month)
      assert_raise Ecto.NoResultsError, fn -> PolicyHandler.get_policy!(policy.id) end
    end

    test "change_policy/1 returns a policy changeset" do
      policy = policy_fixture()
      assert %Ecto.Changeset{} = PolicyHandler.change_policy(policy)
    end
  end
end
