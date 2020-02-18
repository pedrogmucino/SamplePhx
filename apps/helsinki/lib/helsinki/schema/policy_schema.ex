defmodule AccountingSystem.PolicySchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "policies" do
    field :audited, :boolean, default: false
    field :concept, :string
    field :fiscal_exercise, :integer
    field :has_documents, :boolean, default: false
    field :period, :integer
    field :policy_date, :date
    field :policy_number, :integer
    field :policy_type, :integer

    timestamps()

    #has_many :auxiliaries, AccountingSystem.AuxiliarySchema, foreign_key: :policy_number
  end

  @doc false
  def changeset(policy, attrs) do
    policy
    |> cast(attrs, [:policy_number, :policy_type, :period, :fiscal_exercise, :policy_date, :concept, :audited, :has_documents])
    |> validate_required([:policy_number, :policy_type, :period, :fiscal_exercise, :policy_date, :concept, :audited, :has_documents])
  end
end
