defmodule AccountingSystem.Repo.Migrations.CreateTableAuxiliaries20201 do
  use Ecto.Migration

  def change do
    create table(:auxiliaries, prefix: :period_2020_1) do
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
      add :policy_id, references(:policies, prefix: :period_2020_1)
      add :xml_id, :binary_id, autogenerate: true
      add :xml_name, :string, size: 256
      timestamps()
    end
  end
end
