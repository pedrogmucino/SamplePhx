defmodule AccountingSystem.Repo.Migrations.AddXmlPublic do
  use Ecto.Migration

  def change do
    alter table(:auxiliaries) do
      add :xml_id, :binary_id, autogenerate: true
      add :xml_name, :string, size: 256
    end
  end
end
