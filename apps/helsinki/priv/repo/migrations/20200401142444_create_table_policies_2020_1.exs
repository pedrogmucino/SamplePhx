defmodule AccountingSystem.Repo.Migrations.CreateTablePolicies20201 do
  use Ecto.Migration

  def up do
    create table(:policies, prefix: :period_2020_1) do
      add :serial, :string, size: 10
      add :policy_number, :integer
      add :policy_type, :integer
      add :period, :integer
      add :fiscal_exercise, :integer
      add :policy_date, :date
      add :concept, :string
      add :audited, :boolean, default: false, null: false
      add :has_documents, :boolean, default: false, null: false
      add :status, :boolean, default: true
      timestamps()
    end
    flush()
    create unique_index(:policies, [:serial, :policy_number], prefix: "period_2020_1")
  end

  def down do
    drop table(:policies, prefix: :period_2020_1)
    flush()
    drop unique_index(:policies, [:serial, :policy_number], prefix: "period_2020_1")
  end
end
