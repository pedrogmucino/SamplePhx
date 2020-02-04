defmodule AccountingSystem.Repo.Migrations.AddDescriptionToAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :description, :string, size: 128
    end
  end
end
