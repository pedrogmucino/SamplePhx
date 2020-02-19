defmodule AccountingSystem.Repo.Migrations.AlterSeriesNumber do
  use Ecto.Migration

  def change do
    rename table(:series), :number, to: :fiscal_exercise
  end
end
