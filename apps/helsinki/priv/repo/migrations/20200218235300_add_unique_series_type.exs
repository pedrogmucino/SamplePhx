defmodule AccountingSystem.Repo.Migrations.AddUniqueSeriesType do
  use Ecto.Migration

  def up do
    create unique_index(:series, [:policy_type_id, :number])
  end

  def down do
    drop unique_index(:series, [:policy_type_id, :number])
  end
end
