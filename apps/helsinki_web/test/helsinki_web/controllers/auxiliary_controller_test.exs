defmodule AccountingSystemWeb.AuxiliaryControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.AuxiliaryHandler

  @create_attrs %{amount: 120.5, concept: "some concept", cost_center: 42, counterpart: "some counterpart", debit_credit: "d", department: 42, exchange_rate: 120.5, group: 42, id_account: 42, iduuid: 42, mxn_amount: 120.5, policy_number: 42}
  @update_attrs %{amount: 456.7, concept: "some updated concept", cost_center: 43, counterpart: "some updated counterpart", debit_credit: "s", department: 43, exchange_rate: 456.7, group: 43, id_account: 43, iduuid: 43, mxn_amount: 456.7, policy_number: 43}
  @invalid_attrs %{amount: nil, concept: nil, cost_center: nil, counterpart: nil, debit_credit: nil, department: nil, exchange_rate: nil, group: nil, id_account: nil, iduuid: nil, mxn_amount: nil, policy_number: nil}

  def fixture(:auxiliary) do
    {:ok, auxiliary} = AuxiliaryHandler.create_auxiliary(@create_attrs)
    auxiliary
  end

  describe "index" do
    test "lists all auxiliaries", %{conn: conn} do
      conn = get(conn, Routes.auxiliary_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Auxiliaries"
    end
  end

  describe "new auxiliary" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.auxiliary_path(conn, :new))
      assert html_response(conn, 200) =~ "New Auxiliary"
    end
  end

  describe "create auxiliary" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.auxiliary_path(conn, :create), auxiliary_schema: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.auxiliary_path(conn, :show, id)

      conn = get(conn, Routes.auxiliary_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Auxiliary"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.auxiliary_path(conn, :create), auxiliary_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Auxiliary"
    end
  end

  describe "edit auxiliary" do
    setup [:create_auxiliary]

    test "renders form for editing chosen auxiliary", %{conn: conn, auxiliary: auxiliary} do
      conn = get(conn, Routes.auxiliary_path(conn, :edit, auxiliary))
      assert html_response(conn, 200) =~ "Edit Auxiliary"
    end
  end

  describe "update auxiliary" do
    setup [:create_auxiliary]

    test "redirects when data is valid", %{conn: conn, auxiliary: auxiliary} do
      conn = put(conn, Routes.auxiliary_path(conn, :update, auxiliary), auxiliary_schema: @update_attrs)
      assert redirected_to(conn) == Routes.auxiliary_path(conn, :show, auxiliary)

      conn = get(conn, Routes.auxiliary_path(conn, :show, auxiliary))
      assert html_response(conn, 200) =~ "some updated concept"
    end

    test "renders errors when data is invalid", %{conn: conn, auxiliary: auxiliary} do
      conn = put(conn, Routes.auxiliary_path(conn, :update, auxiliary), auxiliary_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Auxiliary"
    end
  end

  describe "delete auxiliary" do
    setup [:create_auxiliary]

    test "deletes chosen auxiliary", %{conn: conn, auxiliary: auxiliary} do
      conn = delete(conn, Routes.auxiliary_path(conn, :delete, auxiliary))
      assert redirected_to(conn) == Routes.auxiliary_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.auxiliary_path(conn, :show, auxiliary))
      end
    end
  end

  defp create_auxiliary(_) do
    auxiliary = fixture(:auxiliary)
    {:ok, auxiliary: auxiliary}
  end
end
