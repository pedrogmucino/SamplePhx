defmodule AccountingSystem.QueryPeriodSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "queryperiods" do
    field :end_date, :date
    field :name, :string
    field :start_date, :date

    timestamps()
  end

  @doc false
  def changeset(query_period, attrs) do
    query_period
    |> cast(attrs, [:name, :start_date, :end_date])
    |> validate_required([:name, :start_date, :end_date])
  end
end
