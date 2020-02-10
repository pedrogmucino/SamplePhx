defmodule AccountingSystem.Repo.Migrations.CreateThirdpartyoperations do
  use Ecto.Migration

  def change do
    create table(:thirdpartyoperations) do
      add :policy_id, :integer
      add :account_number, :string, size: 64
      add :provider_id, :integer

      timestamps()
    end

  end
end
