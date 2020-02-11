defmodule AccountingSystem.GetAllIdName do
  import Ecto.Query, warn: false

  def id_name() do
    from x in "policytypes",
      select: %{key: x.name, value: x.id}
  end
end
