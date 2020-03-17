defmodule AccountingSystemWeb.AuxiliaryController do
  use AccountingSystemWeb, :controller

  alias AccountingSystem.{
    AuxiliarySchema,
    AuxiliaryHandler
  }

  def index(conn, _params) do
    auxiliaries = AuxiliaryHandler.list_auxiliaries()
    render(conn, "index.html", auxiliaries: auxiliaries)
  end

  def new(conn, _params) do
    changeset = AuxiliaryHandler.change_auxiliary(%AuxiliarySchema{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(auxiliary_params, policy_number, year, month) do
    #Cada auxiliar se debe guardar en la base
    AuxiliaryHandler.create_auxiliary(AuxiliaryHandler.format_to_save(auxiliary_params, policy_number, 1), year, month)
  end

  def show(conn, %{"id" => id}) do
    auxiliary = AuxiliaryHandler.get_auxiliary!(id)
    render(conn, "show.html", auxiliary: auxiliary)
  end

  def edit(conn, %{"id" => id}) do
    auxiliary = AuxiliaryHandler.get_auxiliary!(id)
    changeset = AuxiliaryHandler.change_auxiliary(auxiliary)
    render(conn, "edit.html", auxiliary: auxiliary, changeset: changeset)
  end

  def update(conn, %{"id" => id, "auxiliary_schema" => auxiliary_params}) do
    auxiliary = AuxiliaryHandler.get_auxiliary!(id)

    case AuxiliaryHandler.update_auxiliary(auxiliary, auxiliary_params) do
      {:ok, auxiliary} ->
        conn
        |> put_flash(:info, "Auxiliary updated successfully.")
        |> redirect(to: Routes.auxiliary_path(conn, :show, auxiliary))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", auxiliary: auxiliary, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    auxiliary = AuxiliaryHandler.get_auxiliary!(id)
    {:ok, _auxiliary} = AuxiliaryHandler.delete_auxiliary(auxiliary)

    conn
    |> put_flash(:info, "Auxiliary deleted successfully.")
    |> redirect(to: Routes.auxiliary_path(conn, :index))
  end
end
