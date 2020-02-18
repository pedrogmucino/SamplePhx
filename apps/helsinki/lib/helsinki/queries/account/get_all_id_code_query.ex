defmodule AccountingSystem.GetAllIdCode do
  import Ecto.Query, warn: false

  def id_code() do
    from x in "accounts",
      select: %{key: x.code, value: x.id},
      order_by: [x.code]
  end
end
