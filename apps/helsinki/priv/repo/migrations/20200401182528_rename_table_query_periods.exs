defmodule AccountingSystem.Repo.Migrations.RenameTableQueryPeriods do
  use Ecto.Migration

  def change do
    rename table("queryperiods"), to: table("periods")
  end
end
