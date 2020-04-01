defmodule AccountingSystem.Repo.Migrations.CreateSchema20204 do
  use Ecto.Migration

  def up do
    execute "CREATE SCHEMA period_2020_4"
  end

  def down do
    execute "DROP SCHEMA period_2020_4"
  end
end
