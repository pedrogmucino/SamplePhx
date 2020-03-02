defmodule AccountingSystem.Repo.Migrations.CreateSeries do
  use Ecto.Migration

  def change do
    create table(:series) do
      add :serial, :string, size: 10
      add :number, :integer
      add :current_number, :integer
      add :policy_type_id, references(:policytypes, on_delete: :nothing)

      timestamps()
    end

    create index(:series, [:policy_type_id])
  end
end
