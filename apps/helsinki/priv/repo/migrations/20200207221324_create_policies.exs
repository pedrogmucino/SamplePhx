defmodule AccountingSystem.Repo.Migrations.CreatePolicies do
  use Ecto.Migration

  def change do
    create table(:policies) do
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
