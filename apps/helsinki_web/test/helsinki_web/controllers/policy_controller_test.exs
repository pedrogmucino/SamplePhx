defmodule AccountingSystemWeb.PolicyControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.PolicyHandler

  @create_attrs %{"audited" => true, "concept" => "some concept", "fiscal_exercise" => 42, "has_documents" => true, "period" => 42, "policy_date" => ~D[2010-04-17], "policy_number" => 42, "policy_type" => 42}
  @update_attrs %{audited: false, concept: "some updated concept", fiscal_exercise: 43, has_documents: false, period: 43, policy_date: ~D[2011-05-18], policy_number: 43, policy_type: 43}
  @invalid_attrs %{audited: nil, concept: nil, fiscal_exercise: nil, has_documents: nil, period: nil, policy_date: nil, policy_number: nil, policy_type: nil}

  def fixture(:policy) do
    {:ok, policy} = PolicyHandler.create_policy(@create_attrs)
    policy
  end

  describe "index" do
    test "lists all policies", %{conn: conn} do
      conn = get(conn, Routes.policy_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Policies"
    end
  end

  describe "new policy" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.policy_path(conn, :new))
      assert html_response(conn, 200) =~ "New Policy"
    end
  end

  describe "create policy" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.policy_path(conn, :create), policy_schema: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.policy_path(conn, :show, id)

      conn = get(conn, Routes.policy_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Policy"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.policy_path(conn, :create), policy_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Policy"
    end
  end

  describe "edit policy" do
    setup [:create_policy]

    test "renders form for editing chosen policy", %{conn: conn, policy: policy} do
      conn = get(conn, Routes.policy_path(conn, :edit, policy))
      assert html_response(conn, 200) =~ "Edit Policy"
    end
  end

  describe "update policy" do
    setup [:create_policy]

    test "redirects when data is valid", %{conn: conn, policy: policy} do
      conn = put(conn, Routes.policy_path(conn, :update, policy), policy_schema: @update_attrs)
      assert redirected_to(conn) == Routes.policy_path(conn, :show, policy)

      conn = get(conn, Routes.policy_path(conn, :show, policy))
      assert html_response(conn, 200) =~ "some updated concept"
    end

    test "renders errors when data is invalid", %{conn: conn, policy: policy} do
      conn = put(conn, Routes.policy_path(conn, :update, policy), policy_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Policy"
    end
  end

  describe "delete policy" do
    setup [:create_policy]

    test "deletes chosen policy", %{conn: conn, policy: policy} do
      conn = delete(conn, Routes.policy_path(conn, :delete, policy))
      assert redirected_to(conn) == Routes.policy_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.policy_path(conn, :show, policy))
      end
    end
  end

  defp create_policy(_) do
    policy = fixture(:policy)
    {:ok, policy: policy}
  end
end
