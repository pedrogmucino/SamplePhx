defmodule AccountingSystem.Repo.Migrations.CreateSchema20203 do
  use Ecto.Migration

  def up do
    execute "CREATE SCHEMA period_2020_3"
  end

  def down do
    execute "DROP SCHEMA period_2020_3"
  end
end
