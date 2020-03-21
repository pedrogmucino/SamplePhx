defmodule AccountingSystem.GetFromParent do
  @moduledoc """
  Módulo que contiene el query para consultar el nombre de una cuenta por id
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  def the_name(id) do
    from(x in "accounts", select: x.name, where: x.id == ^id)
  end
end
