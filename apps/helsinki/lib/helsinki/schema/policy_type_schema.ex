defmodule AccountingSystem.PolicyTypeSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "policytypes" do
    field :identifier, :string
    field :name, :string
    field :classat, :integer

    timestamps()
  end

  @doc false
  def changeset(policy_type, attrs) do
    policy_type
    |> cast(attrs, [:identifier, :name, :classat])
    |> validate_required([:identifier, :name, :classat])
  end
end
