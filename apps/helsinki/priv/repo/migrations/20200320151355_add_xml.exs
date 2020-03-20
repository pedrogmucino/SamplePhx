defmodule AccountingSystem.Repo.Migrations.AddXml do
  use Ecto.Migration

  def change do
    alter table(:auxiliaries, prefix: :period_2020_3) do
      add :xml_id, :binary_id, autogenerate: true
      add :xml_name, :string, size: 256
    end
  end
end
