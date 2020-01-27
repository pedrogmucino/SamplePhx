defmodule AccountingSystem.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :code, :string, size: 128
      add :status, :string, size: 1
      add :type, :string, size: 1
      add :name, :string, size: 64
      add :level, :integer
      add :is_departamental, :boolean, default: false, null: false
      add :parent_account, :integer
      add :root_account, :integer
      add :character, :boolean, default: false, null: false
      add :group_code, :integer
      add :uuid_voucher, :string, size: 32
      add :payment_method, :boolean, default: false, null: false
      add :apply_to, :integer
      add :third_party_prosecutor, :integer
      add :third_party_op, :boolean, default: false, null: false
      add :apply_third_party_to, :string, size: 2

      timestamps()
    end

  end
end
