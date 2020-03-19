defmodule AccountingSystem.ThirdPartyOperationSchema do
  @moduledoc """
  Esquema de operaciones con terceros
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "thirdpartyoperations" do
    field :account_number, :string
    field :policy_id, :integer
    field :provider_id, :integer

    timestamps()
  end

  @doc false
  def changeset(third_party_operation, attrs) do
    third_party_operation
    |> cast(attrs, [:policy_id, :account_number, :provider_id])
    |> validate_required([:policy_id, :account_number, :provider_id])
  end
end
