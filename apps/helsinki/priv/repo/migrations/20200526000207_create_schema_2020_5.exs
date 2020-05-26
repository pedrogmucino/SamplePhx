defmodule AccountingSystem.Repo.Migrations.CreateSchema20205 do
  use Ecto.Migration

  def up do
    execute "CREATE SCHEMA period_2020_5"
  end

  def down do
    execute "DROP SCHEMA period_2020_5"
  end
end
