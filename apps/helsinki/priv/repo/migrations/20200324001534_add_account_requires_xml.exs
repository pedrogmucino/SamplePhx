defmodule AccountingSystem.Repo.Migrations.AddAccountRequiresXml do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :requires_xml, :boolean, default: false
    end
  end
end
