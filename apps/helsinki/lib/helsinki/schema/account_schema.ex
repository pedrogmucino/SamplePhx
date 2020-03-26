defmodule AccountingSystem.AccountSchema do
  @moduledoc """
  Módulo de Schema de Cuentas
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :apply_third_party_to, :string
    field :apply_to, :integer
    field :character, :boolean, default: false
    field :code, :string
    field :description, :string
    field :group_code, :integer
    field :is_departamental, :boolean, default: false
    field :level, :integer
    field :name, :string
    field :parent_account, :integer
    field :payment_method, :boolean, default: false
    field :root_account, :integer
    field :status, :string
    field :third_party_op, :boolean, default: false
    field :third_party_prosecutor, :integer
    field :type, :string
    field :uuid_voucher, :string
    field :rfc_literals, :string
    field :rfc_numeric, :string
    field :rfc_key, :string
    field :requires_xml, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:code, :status, :type, :name, :description, :level, :is_departamental, :parent_account, :root_account, :character, :group_code, :uuid_voucher, :payment_method, :apply_to, :third_party_prosecutor, :third_party_op, :apply_third_party_to, :rfc_literals, :rfc_numeric, :rfc_key, :requires_xml])
    |> validate_required([:code, :status, :type, :name, :description, :is_departamental, :parent_account, :root_account, :character, :group_code, :uuid_voucher, :payment_method, :apply_to, :third_party_prosecutor, :third_party_op, :apply_third_party_to])
  end
end

defmodule AccountingSystem.AccountCodeSchema do
  @moduledoc """
  Módulo de Schema con lo requierido para el manejo de códigos de Cuenta
  """
  use Ecto.Schema
  import Ecto.Changeset
  schema "accounts" do
    field :code, :string
    field :level, :integer
    field :root_account, :integer
    field :parent_account, :integer
  end

  def changeset(account, attrs) do
    account
      |> cast(attrs, [:code, :level, :root_account, :parent_account])
      |> validate_required([:code, :level, :root_account, :parent_account])
  end
end
