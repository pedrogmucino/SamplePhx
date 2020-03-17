defmodule AccountingSystem.Repo.Migrations.AddStatus2 do
  use Ecto.Migration

  def change do
    alter table(:policies, prefix: :period_2020_3) do
      add :status, :boolean, default: true
    end
  end
end
