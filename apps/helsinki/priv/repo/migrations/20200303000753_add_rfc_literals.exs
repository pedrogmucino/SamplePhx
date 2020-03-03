defmodule AccountingSystem.Repo.Migrations.AddRfcLiterals do
  use Ecto.Migration

  def change do
    rename table(:accounts), :rfc, to: :rfc_literals
  end
end
