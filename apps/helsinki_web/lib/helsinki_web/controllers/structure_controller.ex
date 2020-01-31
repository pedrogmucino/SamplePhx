defmodule AccountingSystemWeb.StructureController do
  use AccountingSystemWeb, :controller

  alias AccountingSystem.StructureHandler
  alias AccountingSystem.StructureSchema
  alias AccountingSystem.GetLastStructureQuery, as: QueryStruct

  def index(conn, _params) do
    structures = StructureHandler.list_structures()
    render(conn, "index.html", structures: structures)
  end

  def new(conn, _params) do
    exist = List.first(QueryStruct.last_structure())
    changeset = StructureHandler.change_structure(StructureHandler.new_structure(exist))
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"structure_schema" => structure_params}) do
    case StructureHandler.create_structure(structure_params) do
      {:ok, structure} ->
        conn
        |> put_flash(:info, "Structure created successfully.")
        |> redirect(to: Routes.structure_path(conn, :show, structure))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    structure = StructureHandler.get_structure!(id)
    render(conn, "show.html", structure: structure)
  end

  def edit(conn, %{"id" => id}) do
    structure = StructureHandler.get_structure!(id)
    changeset = StructureHandler.change_structure(structure)
    render(conn, "edit.html", structure: structure, changeset: changeset)
  end

  def update(conn, %{"id" => id, "structure_schema" => structure_params}) do
    structure = StructureHandler.get_structure!(id)
    case StructureHandler.update_code_size(structure, structure_params) do
      {:error} ->
        conn
        |> put_flash(:error, "Structure can't update because size can't be less than max current size")
        |> redirect(to: Routes.structure_path(conn, :show, structure))
      _ ->
        case StructureHandler.update_structure(structure, structure_params) do
          {:ok, structure} ->
            conn
            |> put_flash(:info, "Structure updated successfully.")
            |> redirect(to: Routes.structure_path(conn, :show, structure))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", structure: structure, changeset: changeset)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    structure = StructureHandler.get_structure!(id)
    {:ok, _structure} = StructureHandler.delete_structure(structure)

    conn
    |> put_flash(:info, "Structure deleted successfully.")
    |> redirect(to: Routes.structure_path(conn, :index))
  end
end

