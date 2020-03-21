defmodule AccountingSystem.GetAllIdName do
  @moduledoc """
  Módulo que contiene los queries oara obtener los tipos de póliza y sus series
  """
  import Ecto.Query, warn: false

  alias AccountingSystem.{
    PolicyTypeSchema,
    SeriesSchema
  }

  def id_name() do
    from x in "policytypes",
      select: %{key: x.name, value: x.id}
  end

  def valid_types_with_serial() do
    from pt in PolicyTypeSchema,
    join: s in SeriesSchema,
    on: s.policy_type_id == pt.id,
    select: %{key: pt.name, value: pt.id}
  end

end
