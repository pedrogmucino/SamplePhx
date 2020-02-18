defmodule AccountingSystem.Repo.Migrations.CreateAuxiliaries do
  use Ecto.Migration

  def change do
    create table(:auxiliaries) do
      add :policy_number, :integer
      add :id_account, :integer
      add :concept, :string, size: 256
      add :debit_credit, :string, size: 1
      add :mxn_amount, :float
      add :amount, :float
      add :department, :integer
      add :counterpart, :string, size: 128
      add :cost_center, :integer
      add :group, :integer
      add :iduuid, :integer
      add :exchange_rate, :float

      timestamps()
    end

  end
end
