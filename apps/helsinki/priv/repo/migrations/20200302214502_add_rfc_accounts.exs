defmodule AccountingSystem.Repo.Migrations.AddRfcAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :rfc, :string, size: 13
    end
  end
end
