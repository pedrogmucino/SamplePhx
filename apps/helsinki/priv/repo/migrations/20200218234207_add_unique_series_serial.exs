defmodule AccountingSystem.Repo.Migrations.AddUniqueSeriesSerial do
  use Ecto.Migration

  def up do
    create unique_index(:series, [:serial, :number])
  end

  def down do
    drop unique_index(:series, [:serial, :number])
  end
end
