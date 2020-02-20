defmodule AccountingSystem.SearchAccount do
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
                |>String.trim
                |>String.replace(" ", "|")
    "%("<>new_text<>")%"
  end

end
