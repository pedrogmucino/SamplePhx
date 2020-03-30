defmodule AccountingSystem.GetSetAccountsCodes do
  @moduledoc """
  Módulo que contiene los queries para consultar y establecer códigos de cuenta
  """
  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  def get_code_and_id() do
    from(data in "accounts", select: [:code, :id])
      |> Repo.all
  end

  def set_new_code(code, id_account) do
    from(acc in "accounts", where: acc.id == ^id_account)
      |> Repo.update_all(set: [code: code])
  end
end
