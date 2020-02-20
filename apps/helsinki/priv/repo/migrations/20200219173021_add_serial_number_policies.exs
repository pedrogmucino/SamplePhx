defmodule AccountingSystem.Repo.Migrations.AddSerialNumberPolicies do
  use Ecto.Migration

  def change do
    alter table(:policies, prefix: :p_2020_2) do
      add :serial, :string, size: 10
    end
  end
end
