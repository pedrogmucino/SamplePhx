defmodule AccountingSystem.GetLastNumber do
  import Ecto.Query, warn: false

  def of_policy() do
    from polly in "policies",
    select: max(polly.policy_number)
  end
end
