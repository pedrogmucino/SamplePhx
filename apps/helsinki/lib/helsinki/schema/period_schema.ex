defmodule AccountingSystem.PeriodSchema do
  @moduledoc """
  Period Scheme
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "periods" do
    field :end_date, :date
    field :name, :string
    field :start_date, :date

    timestamps()
  end

  @doc false
  def changeset(period, attrs) do
    period
    |> cast(attrs, [:name, :start_date, :end_date])
    |> validate_required([:name, :start_date, :end_date])
  end
end
