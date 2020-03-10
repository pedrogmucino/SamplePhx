defmodule AccountingSystem.Repo.Migrations.AddUniqueSerialNumberPolicies3 do
  use Ecto.Migration

  def up do
    create unique_index(:policies, [:serial, :policy_number], prefix: "period_2020_3")
  end

  def down do
    drop unique_index(:policies, [:serial, :policy_number], prefix: "period_2020_3")
  end
end
