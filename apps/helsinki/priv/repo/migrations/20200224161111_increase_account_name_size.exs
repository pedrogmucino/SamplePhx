defmodule AccountingSystem.Repo.Migrations.IncreaseAccountNameSize do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      modify(:name, :string, size: 255)
    end
  end
end
