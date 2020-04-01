defmodule AccountingSystem.Repo.Migrations.CreateSchema20201 do
  use Ecto.Migration

  def up do
    execute "CREATE SCHEMA period_2020_1"
  end

  def down do
    execute "DROP SCHEMA period_2020_1"
  end
end
