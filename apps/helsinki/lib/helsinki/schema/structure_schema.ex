defmodule AccountingSystem.StructureSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "structures" do
    field :size, :integer
    field :level, :integer
    field :max_current_size, :integer

    timestamps()
  end

  @doc false
  def changeset(structure, attrs) do
    structure
    |> cast(attrs, [:size, :level, :max_current_size])
    |> validate_required([:size, :level, :max_current_size])
  end
end
