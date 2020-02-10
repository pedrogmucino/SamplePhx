defmodule AccountingSystemWeb.PolicyTypeController do
  use AccountingSystemWeb, :controller

  alias AccountingSystem.PolicyTipeHandler
  alias AccountingSystem.PolicyTypeSchema

  def index(conn, _params) do
    policytypes = PolicyTipeHandler.list_policytypes()
    render(conn, "index.html", policytypes: policytypes)
  end

  def new(conn, _params) do
    changeset = PolicyTipeHandler.change_policy_type(%PolicyTypeSchema{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"policy_type_schema" => policy_type_params}) do
    case PolicyTipeHandler.create_policy_type(policy_type_params) do
      {:ok, policy_type} ->
        conn
        |> put_flash(:info, "Policy type created successfully.")
        |> redirect(to: Routes.policy_type_path(conn, :show, policy_type))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    policy_type = PolicyTipeHandler.get_policy_type!(id)
    render(conn, "show.html", policy_type: policy_type)
  end

  def edit(conn, %{"id" => id}) do
    policy_type = PolicyTipeHandler.get_policy_type!(id)
    changeset = PolicyTipeHandler.change_policy_type(policy_type)
    render(conn, "edit.html", policy_type: policy_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "policy_type_schema" => policy_type_params}) do
    policy_type = PolicyTipeHandler.get_policy_type!(id)

    case PolicyTipeHandler.update_policy_type(policy_type, policy_type_params) do
      {:ok, policy_type} ->
        conn
        |> put_flash(:info, "Policy type updated successfully.")
        |> redirect(to: Routes.policy_type_path(conn, :show, policy_type))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", policy_type: policy_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    policy_type = PolicyTipeHandler.get_policy_type!(id)
    {:ok, _policy_type} = PolicyTipeHandler.delete_policy_type(policy_type)

    conn
    |> put_flash(:info, "Policy type deleted successfully.")
    |> redirect(to: Routes.policy_type_path(conn, :index))
  end
end
