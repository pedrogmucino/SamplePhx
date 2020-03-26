defmodule AccountingSystem.ProviderSchema do
  @moduledoc """
  Esquema de Proveedor
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "providers" do
    field :provider_name, :string
    field :rfc_provider, :string

    timestamps()
  end

  @doc false
  def changeset(provider, attrs) do
    provider
    |> cast(attrs, [:rfc_provider, :provider_name])
    |> validate_required([:rfc_provider, :provider_name])
  end
end
