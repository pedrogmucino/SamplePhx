defmodule AccountingSystemWeb.ThirdPartyOperationController do
  use AccountingSystemWeb, :controller

  alias AccountingSystem.ThirdPartyOperationHandler
  alias AccountingSystem.ThirdPartyOperationSchema

  def index(conn, _params) do
    thirdpartyoperations = ThirdPartyOperationHandler.list_thirdpartyoperations()
    render(conn, "index.html", thirdpartyoperations: thirdpartyoperations)
  end

  def new(conn, _params) do
    changeset = ThirdPartyOperationHandler.change_third_party_operation(%ThirdPartyOperationSchema{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"third_party_operation_schema" => third_party_operation_params}) do
    case ThirdPartyOperationHandler.create_third_party_operation(third_party_operation_params) do
      {:ok, third_party_operation} ->
        conn
        |> put_flash(:info, "Third party operation created successfully.")
        |> redirect(to: Routes.third_party_operation_path(conn, :show, third_party_operation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    third_party_operation = ThirdPartyOperationHandler.get_third_party_operation!(id)
    render(conn, "show.html", third_party_operation: third_party_operation)
  end

  def edit(conn, %{"id" => id}) do
    third_party_operation = ThirdPartyOperationHandler.get_third_party_operation!(id)
    changeset = ThirdPartyOperationHandler.change_third_party_operation(third_party_operation)
    render(conn, "edit.html", third_party_operation: third_party_operation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "third_party_operation_schema" => third_party_operation_params}) do
    third_party_operation = ThirdPartyOperationHandler.get_third_party_operation!(id)

    case ThirdPartyOperationHandler.update_third_party_operation(third_party_operation, third_party_operation_params) do
      {:ok, third_party_operation} ->
        conn
        |> put_flash(:info, "Third party operation updated successfully.")
        |> redirect(to: Routes.third_party_operation_path(conn, :show, third_party_operation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", third_party_operation: third_party_operation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    third_party_operation = ThirdPartyOperationHandler.get_third_party_operation!(id)
    {:ok, _third_party_operation} = ThirdPartyOperationHandler.delete_third_party_operation(third_party_operation)

    conn
    |> put_flash(:info, "Third party operation deleted successfully.")
    |> redirect(to: Routes.third_party_operation_path(conn, :index))
  end
end
