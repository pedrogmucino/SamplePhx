defmodule AccountingSystem.SeriesSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "series" do
    field :current_number, :integer
    field :number, :integer
    field :serial, :string
    belongs_to :policy_type, AccountingSystem.PolicyTypeSchema

    timestamps()
  end

  @doc false
  def changeset(series, attrs) do
    series
    |> cast(attrs, [:serial, :number, :current_number, :policy_type_id])
    |> validate_required([:serial, :number, :current_number, :policy_type_id])
    |> foreign_key_constraint(:policy_type_id, name: :series_policy_type_id_fkey, message: "Tipo de póliza requerido")
    |> unique_constraint(:serial, name: :series_serial_number_index)
    |> unique_constraint(:number, name: :series_serial_number_index)
    |> unique_constraint(:policy_type_id, name: :series_policy_type_id_number_index)
  end
end
