defmodule AccountingSystem.Repo.Migrations.AddPolicyIdAuxiliaries do
  use Ecto.Migration

  def change do
    alter table(:auxiliaries, prefix: :p_2020_2) do
      add :policy_id, references(:policies, prefix: :p_2020_2)
    end
  end
end
