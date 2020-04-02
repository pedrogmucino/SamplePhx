defmodule AccountingSystem.Repo.Migrations.AddUniqueIndexPeriods do
  use Ecto.Migration

  def change do
    create unique_index(:periods, [:start_date, :end_date])
  end
end
