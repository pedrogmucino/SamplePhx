defmodule AccountingSystemWeb.AccountController do
  use AccountingSystemWeb, :controller

  alias AccountingSystem.AccountHandler
  alias AccountingSystem.CodeFormatter
  alias AccountingSystem.SchemaFormatter
  alias Phoenix.LiveView

  def index_fake(conn, _params) do
    LiveView.Controller.live_render(conn, AccountingSystemWeb.AccountLiveView, session: %{})
  end
  def index(conn, _params) do
    accounts = AccountHandler.list_accounts()
    render(conn, "index.html", accounts: accounts)
  end

  def new(conn, %{"id" => id}) do
    account = AccountHandler.get_account_code!(id)
    #A Account se le debe cambiar todo el formato para que se cree la cuenta hijo
    child = SchemaFormatter.get_child_values(account)
    changeset = AccountHandler.change_account_code(child)
    render(conn, "new.html", changeset: changeset)
  end

  def new(conn, _params) do
    account = AccountHandler.get_principal_account!()
    child = SchemaFormatter.get_root_account(account)
    changeset = AccountHandler.change_account_code(child)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account_code_schema" => account_params}) do
    case AccountHandler.create_account(CodeFormatter.concat_names(account_params)) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> redirect(to: Routes.account_path(conn, :show, account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account = AccountHandler.get_account!(id)
    render(conn, "show.html", account: account)
  end

  def edit(conn, %{"id" => id}) do
    account = AccountHandler.get_account!(id)
    changeset = AccountHandler.change_account(account)
    render(conn, "edit.html", account: account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "account_schema" => account_params}) do
    account = AccountHandler.get_account!(id)

    case AccountHandler.update_account(account, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account updated successfully.")
        |> redirect(to: Routes.account_path(conn, :show, account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", account: account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = AccountHandler.get_account!(id)
    {:ok, _account} = AccountHandler.delete_account(account)

    conn
    |> put_flash(:info, "Account deleted successfully.")
    |> redirect(to: Routes.account_path(conn, :index))
  end
end
