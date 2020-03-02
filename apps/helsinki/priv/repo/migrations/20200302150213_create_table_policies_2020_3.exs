defmodule AccountingSystem.Repo.Migrations.CreateTablePolicies20203 do
  use Ecto.Migration

  def change do
    create table(:policies, prefix: :period_2020_3) do
      add :serial, :string, size: 10
      add :policy_number, :integer
      add :policy_type, :integer
      add :period, :integer
      add :fiscal_exercise, :integer
      add :policy_date, :date
      add :concept, :string
      add :audited, :boolean, default: false, null: false
      add :has_documents, :boolean, default: false, null: false

      timestamps()
    end
  end
end
