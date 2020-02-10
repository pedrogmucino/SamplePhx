defmodule AccountingSystem.Repo.Migrations.CreateProviders do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :rfc_provider, :string, size: 128
      add :provider_name, :string, size: 128

      timestamps()
    end

  end
end
