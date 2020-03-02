defmodule AccountingSystem.Repo.Migrations.AlterSchema20202 do
  use Ecto.Migration

  def up do
    execute "ALTER SCHEMA p_2020_2 RENAME TO period_2020_2"
  end

  def down do
    execute "ALTER SCHEMA period_2020_2 RENAME TO p_2020_2"
  end
end
