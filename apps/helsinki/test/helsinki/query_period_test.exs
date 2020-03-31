defmodule AccountingSystem.QueryPeriodsTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.QueryPeriodHandler

  describe "queryperiods" do
    alias AccountingSystem.QueryPeriodSchema

    @valid_attrs %{end_date: ~D[2010-04-17], name: "some name", start_date: ~D[2010-04-17]}
    @update_attrs %{end_date: ~D[2011-05-18], name: "some updated name", start_date: ~D[2011-05-18]}
    @invalid_attrs %{end_date: nil, name: nil, start_date: nil}

    def query_period_fixture(attrs \\ %{}) do
      {:ok, query_period} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QueryPeriodHandler.create_query_period()

      query_period
    end

    test "list_queryperiods/0 returns all queryperiods" do
      query_period = query_period_fixture()
      assert QueryPeriodHandler.list_queryperiods() == [query_period]
    end

    test "get_query_period!/1 returns the query_period with given id" do
      query_period = query_period_fixture()
      assert QueryPeriodHandler.get_query_period!(query_period.id) == query_period
    end

    test "create_query_period/1 with valid data creates a query_period" do
      assert {:ok, %QueryPeriodSchema{} = query_period} = QueryPeriodHandler.create_query_period(@valid_attrs)
      assert query_period.end_date == ~D[2010-04-17]
      assert query_period.name == "some name"
      assert query_period.start_date == ~D[2010-04-17]
    end

    test "create_query_period/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QueryPeriodHandler.create_query_period(@invalid_attrs)
    end

    test "update_query_period/2 with valid data updates the query_period" do
      query_period = query_period_fixture()
      assert {:ok, %QueryPeriodSchema{} = query_period} = QueryPeriodHandler.update_query_period(query_period, @update_attrs)
      assert query_period.end_date == ~D[2011-05-18]
      assert query_period.name == "some updated name"
      assert query_period.start_date == ~D[2011-05-18]
    end

    test "update_query_period/2 with invalid data returns error changeset" do
      query_period = query_period_fixture()
      assert {:error, %Ecto.Changeset{}} = QueryPeriodHandler.update_query_period(query_period, @invalid_attrs)
      assert query_period == QueryPeriodHandler.get_query_period!(query_period.id)
    end

    test "delete_query_period/1 deletes the query_period" do
      query_period = query_period_fixture()
      assert {:ok, %QueryPeriodSchema{}} = QueryPeriodHandler.delete_query_period(query_period)
      assert_raise Ecto.NoResultsError, fn -> QueryPeriodHandler.get_query_period!(query_period.id) end
    end

    test "change_query_period/1 returns a query_period changeset" do
      query_period = query_period_fixture()
      assert %Ecto.Changeset{} = QueryPeriodHandler.change_query_period(query_period)
    end
  end
end
