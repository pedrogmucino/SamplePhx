defmodule AccountingSystem.Repo.Migrations.CreateStructures do
  use Ecto.Migration

  def change do
    create table(:structures) do
      add :size, :integer
      add :level, :integer
      add :max_current_size, :integer

      timestamps()
    end

  end
end
