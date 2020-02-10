defmodule AccountingSystem.Repo.Migrations.CreatePolicytypes do
  use Ecto.Migration

  def change do
    create table(:policytypes) do
      add :identifier, :string, size: 2
      add :name, :string, size: 32
      add :classat, :integer

      timestamps()
    end

  end
end
