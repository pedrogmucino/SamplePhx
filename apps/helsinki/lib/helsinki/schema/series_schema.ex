defmodule AccountingSystem.SeriesSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "series" do
    field :current_number, :integer
    field :number, :integer
    field :serial, :string
    field :policy_type_id, :id

    timestamps()
  end

  @doc false
  def changeset(series, attrs) do
    series
    |> cast(attrs, [:serial, :number, :current_number])
    |> validate_required([:serial, :number, :current_number])
  end
end
