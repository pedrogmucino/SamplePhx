defmodule AccountingSystem.StructureSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "structures" do
    field :length, :integer
    field :max, :integer
    field :order, :integer

    timestamps()
  end

  @doc false
  def changeset(structure, attrs) do
    structure
    |> cast(attrs, [:length, :order, :max])
    |> validate_required([:length, :order, :max])
  end
end
