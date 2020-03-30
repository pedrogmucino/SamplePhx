defmodule AccountingSystem.GetRequiresXml do
  @moduledoc """
  Módulo que contiene el query para obtener el campo requires_xml de una cuenta
  """
  import Ecto.Query, warn: false

  def new(code) do
    from acc in AccountingSystem.AccountSchema,
    where: acc.code == ^code,
    select: acc.requires_xml
  end

end
