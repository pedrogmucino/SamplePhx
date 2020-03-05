defmodule AccountingSystem.Repo.Migrations.AddStatus do
  use Ecto.Migration

  def change do
    alter table(:policies, prefix: :period_2020_2) do
      add :status, :boolean, default: true
    end
  end
end
