defmodule AccountingSystem.GetDescription do
  @moduledoc """
  Módulo que contiene el query para la descripción de una cuenta por id
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.AccountSchema

  def get_by_id(id) do
    from acc in AccountSchema, select: acc.description, where: acc.id == ^id
  end
end
