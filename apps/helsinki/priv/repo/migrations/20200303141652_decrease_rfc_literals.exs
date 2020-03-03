defmodule AccountingSystem.Repo.Migrations.DecreaseRfcLiterals do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      modify(:rfc_literals, :string, size: 4)
    end
  end
end
