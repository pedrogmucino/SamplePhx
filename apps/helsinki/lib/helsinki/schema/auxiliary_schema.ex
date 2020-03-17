defmodule AccountingSystem.AuxiliarySchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auxiliaries" do
    field :amount, :float
    field :concept, :string
    field :cost_center, :integer
    field :counterpart, :string
    field :debit_credit, :string
    field :department, :integer
    field :exchange_rate, :float
    field :group, :integer
    field :id_account, :integer
    field :iduuid, :integer
    field :mxn_amount, :float
    field :policy_number, :integer
    belongs_to :policy, AccountingSystem.PolicySchema

    timestamps()
  end

  @doc false
  def changeset(auxiliary, attrs) do
    auxiliary
    |> cast(attrs, [:policy_number, :id_account, :concept, :debit_credit, :mxn_amount, :amount, :department, :exchange_rate, :policy_id])
    |> validate_required([:policy_number, :id_account, :concept, :debit_credit, :mxn_amount, :amount, :exchange_rate, :policy_id])
  end
end
