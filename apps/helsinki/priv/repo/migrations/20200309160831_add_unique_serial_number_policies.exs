defmodule AccountingSystem.Repo.Migrations.AddUniqueSerialNumberPolicies do
  use Ecto.Migration

  def up do
    create unique_index(:policies, [:serial, :policy_number], prefix: "period_2020_2")
  end

  def down do
    drop unique_index(:policies, [:serial, :policy_number], prefix: "period_2020_2")
  end
end
