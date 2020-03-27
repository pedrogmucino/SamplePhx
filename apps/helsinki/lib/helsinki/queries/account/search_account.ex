defmodule AccountingSystem.SearchAccount do
  @moduledoc """
  Módulo que contiene los queries para realizar búsquedas de cuentas en base a un texto
  """
  import Ecto.Query, warn: false

  def search(text) do
    search = format(text)
    from acc in AccountingSystem.AccountSchema,
      select: %{key: [acc.code, " ", acc.description], value: acc.id},
      where: fragment("a0.code SIMILAR TO (?)", ^search) or fragment("a0.description SIMILAR TO (?)", ^search) or fragment("a0.name SIMILAR TO (?)", ^search)
  end

  def search_from_text(text) do
    search = format(text)
    from acc in AccountingSystem.AccountSchema,
      where: fragment("a0.code SIMILAR TO (?)", ^search) or fragment("a0.description SIMILAR TO (?)", ^search) or fragment("a0.name SIMILAR TO (?)", ^search)
  end

  def format(text) do
    new_text = text
                |> String.trim
                |> String.replace(" ", "|")
    "%("<> new_text <> ")%"
  end

  def search_detail_account(text) do
    search = format(text)
    from acc in AccountingSystem.AccountSchema,
      select: %{key: [acc.code, " ", acc.description], value: acc.id, req_xml: acc.requires_xml},
      where: acc.type == "D" and acc.status == "A" and
      (fragment("a0.code SIMILAR TO (?)", ^search) or fragment("a0.description SIMILAR TO (?)", ^search) or fragment("a0.name SIMILAR TO (?)", ^search))
  end

  def all_detail() do
    #Qué necesito de la cuenta para llenar el aux?????
    from acc in AccountingSystem.AccountSchema,
      select: [acc.id, acc.code, acc.description],
      where: acc.type == "D" and acc.status == "A"
  end
end
