defmodule AccountingSystemWeb.StructureControllerTest do
  use AccountingSystemWeb.ConnCase

  alias AccountingSystem.StructureHandler

  @create_attrs %{"size" => 42, "max_current_size" => 0, "level" => 0}
  @update_attrs %{"size" => "43", "max_current_size" => 1, "level" => 0}
  @invalid_attrs %{"size" => "0", "max_current_size" => nil, "level" => nil}

  def fixture(:structure) do
    {:ok, structure} = StructureHandler.create_structure(@create_attrs)
    structure
  end

  describe "index" do
    test "lists all structures", %{conn: conn} do
      conn = get(conn, Routes.structure_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Structures"
    end
  end

  describe "new structure" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.structure_path(conn, :new))
      assert html_response(conn, 200) =~ "New Structure"
    end
  end

  describe "create structure" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.structure_path(conn, :create), structure_schema: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.structure_path(conn, :show, id)

      conn = get(conn, Routes.structure_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Structure"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.structure_path(conn, :create), structure_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Structure"
    end
  end

  describe "edit structure" do
    setup [:create_structure]

    test "renders form for editing chosen structure", %{conn: conn, structure: structure} do
      conn = get(conn, Routes.structure_path(conn, :edit, structure))
      assert html_response(conn, 200) =~ "Edit Structure"
    end
  end

  describe "update structure" do
    setup [:create_structure]

    test "redirects when data is valid", %{conn: conn, structure: structure} do
      conn = put(conn, Routes.structure_path(conn, :update, structure), structure_schema: @update_attrs)
      assert redirected_to(conn) == Routes.structure_path(conn, :show, structure)

      conn = get(conn, Routes.structure_path(conn, :show, structure))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, structure: structure} do
      conn = put(conn, Routes.structure_path(conn, :update, structure), structure_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Structure"
    end
  end

  describe "delete structure" do
    setup [:create_structure]

    test "deletes chosen structure", %{conn: conn, structure: structure} do
      conn = delete(conn, Routes.structure_path(conn, :delete, structure))
      assert redirected_to(conn) == Routes.structure_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.structure_path(conn, :show, structure))
      end
    end
  end

  defp create_structure(_) do
    structure = fixture(:structure)
    {:ok, structure: structure}
  end
end
