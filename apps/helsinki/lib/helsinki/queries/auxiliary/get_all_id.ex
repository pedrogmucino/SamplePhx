defmodule AccountingSystem.GetAllId do
  import Ecto.Query, warn: false
  alias AccountingSystem.Repo
  alias AccountingSystem.PrefixFormatter

  def from_policy(policy_number) do
    from aux in "auxiliaries",
    join: pollys in "policies",
    on: pollys.id == ^policy_number and aux.policy_number == pollys.policy_number,
    select: aux.id
  end
end
