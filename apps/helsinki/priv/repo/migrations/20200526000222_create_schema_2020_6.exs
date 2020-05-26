defmodule AccountingSystem.Repo.Migrations.CreateSchema20206 do
  use Ecto.Migration

  def up do
    execute "CREATE SCHEMA period_2020_6"
  end

  def down do
    execute "DROP SCHEMA period_2020_6"
  end
end
