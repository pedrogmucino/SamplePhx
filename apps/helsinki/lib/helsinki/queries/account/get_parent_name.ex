defmodule AccountingSystem.GetFromParent do
  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  def the_name(id) do
    from(x in "accounts", select: x.name, where: x.id == ^id)
  end
end
