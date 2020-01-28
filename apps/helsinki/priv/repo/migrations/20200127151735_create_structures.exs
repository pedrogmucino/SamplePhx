defmodule AccountingSystem.Repo.Migrations.CreateStructures do
  use Ecto.Migration

  def change do
    create table(:structures) do
      add :length, :integer
      add :order, :integer
      add :max, :integer

      timestamps()
    end

  end
end
