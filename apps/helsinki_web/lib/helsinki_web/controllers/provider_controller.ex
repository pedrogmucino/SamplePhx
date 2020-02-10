defmodule AccountingSystemWeb.ProviderController do
  use AccountingSystemWeb, :controller

  alias AccountingSystem.ProviderHandler
  alias AccountingSystem.ProviderSchema

  def index(conn, _params) do
    providers = ProviderHandler.list_providers()
    render(conn, "index.html", providers: providers)
  end

  def new(conn, _params) do
    changeset = ProviderHandler.change_provider(%ProviderSchema{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"provider_schema" => provider_params}) do
    case ProviderHandler.create_provider(provider_params) do
      {:ok, provider} ->
        conn
        |> put_flash(:info, "Provider created successfully.")
        |> redirect(to: Routes.provider_path(conn, :show, provider))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    provider = ProviderHandler.get_provider!(id)
    render(conn, "show.html", provider: provider)
  end

  def edit(conn, %{"id" => id}) do
    provider = ProviderHandler.get_provider!(id)
    changeset = ProviderHandler.change_provider(provider)
    render(conn, "edit.html", provider: provider, changeset: changeset)
  end

  def update(conn, %{"id" => id, "provider_schema" => provider_params}) do
    provider = ProviderHandler.get_provider!(id)

    case ProviderHandler.update_provider(provider, provider_params) do
      {:ok, provider} ->
        conn
        |> put_flash(:info, "Provider updated successfully.")
        |> redirect(to: Routes.provider_path(conn, :show, provider))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", provider: provider, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    provider = ProviderHandler.get_provider!(id)
    {:ok, _provider} = ProviderHandler.delete_provider(provider)

    conn
    |> put_flash(:info, "Provider deleted successfully.")
    |> redirect(to: Routes.provider_path(conn, :index))
  end
end
