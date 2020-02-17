defmodule AccountingSystemWeb.PolicyController do
  use AccountingSystemWeb, :controller

  alias Phoenix.LiveView

  alias AccountingSystem.PolicyHandler

  def index(conn, _params) do
    policies = PolicyHandler.list_policies()
    render(conn, "index.html", policies: policies)
  end

  def new(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.PolicyLiveView, session: %{})
  end

  def create(conn, %{"policy_schema" => policy_params}) do
    case PolicyHandler.create_policy(policy_params) do
      {:ok, policy} ->
        conn
        |> put_flash(:info, "Policy created successfully.")
        |> redirect(to: Routes.policy_path(conn, :show, policy))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    policy = PolicyHandler.get_policy!(id)
    render(conn, "show.html", policy: policy)
  end

  def edit(conn, %{"id" => id}) do
    policy = PolicyHandler.get_policy!(id)
    changeset = PolicyHandler.change_policy(policy)
    render(conn, "edit.html", policy: policy, changeset: changeset)
  end

  def update(conn, %{"id" => id, "policy_schema" => policy_params}) do
    policy = PolicyHandler.get_policy!(id)

    case PolicyHandler.update_policy(policy, policy_params) do
      {:ok, policy} ->
        conn
        |> put_flash(:info, "Policy updated successfully.")
        |> redirect(to: Routes.policy_path(conn, :show, policy))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", policy: policy, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case PolicyHandler.delete_policy_with_aux(id) do
      {:ok, :ok} ->
        conn
          |> put_flash(:info, "Policy deleted successfully.")
          |> redirect(to: Routes.policy_path(conn, :index))
      _ ->
        conn
          |> put_flash(:error, "No se ha podido eliminar")
          |> redirect(to: Routes.policy_path(conn, :index))
    end
  end

end
