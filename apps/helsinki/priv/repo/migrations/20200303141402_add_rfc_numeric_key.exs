defmodule AccountingSystem.Repo.Migrations.AddRfcNumericKey do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :rfc_numeric, :string, size: 6
      add :rfc_key, :string, size: 3
    end
  end
end
