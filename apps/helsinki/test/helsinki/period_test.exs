defmodule AccountingSystem.PeriodsTest do
  use AccountingSystem.DataCase

  alias AccountingSystem.PeriodHandler

  describe "periods" do
    alias AccountingSystem.PeriodSchema

    @valid_attrs %{end_date: ~D[2010-04-17], name: "some name", start_date: ~D[2010-04-17]}
    @update_attrs %{end_date: ~D[2011-05-18], name: "some updated name", start_date: ~D[2011-05-18]}
    @invalid_attrs %{end_date: nil, name: nil, start_date: nil}

    def period_fixture(attrs \\ %{}) do
      {:ok, period} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PeriodHandler.create_period()

      period
    end

    test "list_periods/0 returns all periods" do
      period = period_fixture()
      assert PeriodHandler.list_periods() == [period]
    end

    test "get_period!/1 returns the period with given id" do
      period = period_fixture()
      assert PeriodHandler.get_period!(period.id) == period
    end

    test "create_period/1 with valid data creates a period" do
      assert {:ok, %PeriodSchema{} = period} = PeriodHandler.create_period(@valid_attrs)
      assert period.end_date == ~D[2010-04-17]
      assert period.name == "some name"
      assert period.start_date == ~D[2010-04-17]
    end

    test "create_period/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PeriodHandler.create_period(@invalid_attrs)
    end

    test "update_period/2 with valid data updates the period" do
      period = period_fixture()
      assert {:ok, %PeriodSchema{} = period} = PeriodHandler.update_period(period, @update_attrs)
      assert period.end_date == ~D[2011-05-18]
      assert period.name == "some updated name"
      assert period.start_date == ~D[2011-05-18]
    end

    test "update_period/2 with invalid data returns error changeset" do
      period = period_fixture()
      assert {:error, %Ecto.Changeset{}} = PeriodHandler.update_period(period, @invalid_attrs)
      assert period == PeriodHandler.get_period!(period.id)
    end

    test "delete_period/1 deletes the period" do
      period = period_fixture()
      assert {:ok, %PeriodSchema{}} = PeriodHandler.delete_period(period)
      assert_raise Ecto.NoResultsError, fn -> PeriodHandler.get_period!(period.id) end
    end

    test "change_period/1 returns a period changeset" do
      period = period_fixture()
      assert %Ecto.Changeset{} = PeriodHandler.change_period(period)
    end
  end
end
