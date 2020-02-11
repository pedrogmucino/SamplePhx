defmodule AccountingSystem.Repo.Migrations.CreateSchema20202 do
  use Ecto.Migration

  def up do
    execute "CREATE SCHEMA p_2020_2"
  end

  def down do
    execute "DROP SCHEMA p_2020_2"
  end
end
