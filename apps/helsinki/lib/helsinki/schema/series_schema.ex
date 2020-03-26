defmodule AccountingSystem.SeriesSchema do
  @moduledoc """
  Esquema de Series
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "series" do
    field :current_number, :integer
    field :fiscal_exercise, :integer
    field :serial, :string
    belongs_to :policy_type, AccountingSystem.PolicyTypeSchema

    timestamps()
  end

  @doc false
  def changeset(series, attrs) do
    series
    |> cast(attrs, [:serial, :fiscal_exercise, :current_number, :policy_type_id])
    |> validate_required([:serial, :fiscal_exercise, :current_number, :policy_type_id])
    |> foreign_key_constraint(:policy_type_id, name: :series_policy_type_id_fkey, message: "Tipo de póliza requerido")
    |> unique_constraint(:serial, name: :series_serial_number_index)
    |> unique_constraint(:fiscal_exercise, name: :series_serial_number_index)
    |> unique_constraint(:policy_type_id, name: :series_policy_type_id_number_index)
  end
end
