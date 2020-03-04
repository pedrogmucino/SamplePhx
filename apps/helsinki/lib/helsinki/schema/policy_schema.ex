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
    field :serial, :string
    field :status, :boolean, default: true

    timestamps()

    has_many :auxiliaries, AccountingSystem.AuxiliarySchema, foreign_key: :id
  end

  @doc false
  def changeset(policy, attrs) do
    policy
    |> cast(attrs, [:policy_number, :policy_type, :period, :fiscal_exercise, :policy_date, :concept, :audited, :has_documents, :serial, :status])
    |> validate_required([:policy_number, :policy_type, :period, :fiscal_exercise, :policy_date, :concept, :audited, :has_documents, :serial])
  end
end
