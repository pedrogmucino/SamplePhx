defmodule AccountingSystem.Repo.Migrations.CreateQueryperiods do
  use Ecto.Migration

  def change do
    create table(:queryperiods) do
      add :name, :string
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end

  end
end
