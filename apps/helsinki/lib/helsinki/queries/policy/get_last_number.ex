defmodule AccountingSystem.GetLastNumber do
  @moduledoc """
  Módulo que contiene el query para ebtener el número máximo de póliza
  """
  import Ecto.Query, warn: false

  def of_policy() do
    from polly in "policies",
    select: max(polly.policy_number)
  end
end
