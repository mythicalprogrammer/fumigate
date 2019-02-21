defmodule FumigateWeb.AccordControllerTest do
  use FumigateWeb.ConnCase

  alias Fumigate.Fragrance

  @create_attrs %{accord_name: "some accord_name"}
  @update_attrs %{accord_name: "some updated accord_name"}
  @invalid_attrs %{accord_name: nil}

  def fixture(:accord) do
    {:ok, accord} = Fragrance.create_accord(@create_attrs)
    accord
  end

  describe "index" do
    test "lists all accords", %{conn: conn} do
      conn = get(conn, Routes.accord_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Accords"
    end
  end

  describe "new accord" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.accord_path(conn, :new))
      assert html_response(conn, 200) =~ "New Accord"
    end
  end

  describe "create accord" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.accord_path(conn, :create), accord: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.accord_path(conn, :show, id)

      conn = get(conn, Routes.accord_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Accord"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.accord_path(conn, :create), accord: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Accord"
    end
  end

  describe "edit accord" do
    setup [:create_accord]

    test "renders form for editing chosen accord", %{conn: conn, accord: accord} do
      conn = get(conn, Routes.accord_path(conn, :edit, accord))
      assert html_response(conn, 200) =~ "Edit Accord"
    end
  end

  describe "update accord" do
    setup [:create_accord]

    test "redirects when data is valid", %{conn: conn, accord: accord} do
      conn = put(conn, Routes.accord_path(conn, :update, accord), accord: @update_attrs)
      assert redirected_to(conn) == Routes.accord_path(conn, :show, accord)

      conn = get(conn, Routes.accord_path(conn, :show, accord))
      assert html_response(conn, 200) =~ "some updated accord_name"
    end

    test "renders errors when data is invalid", %{conn: conn, accord: accord} do
      conn = put(conn, Routes.accord_path(conn, :update, accord), accord: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Accord"
    end
  end

  describe "delete accord" do
    setup [:create_accord]

    test "deletes chosen accord", %{conn: conn, accord: accord} do
      conn = delete(conn, Routes.accord_path(conn, :delete, accord))
      assert redirected_to(conn) == Routes.accord_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.accord_path(conn, :show, accord))
      end
    end
  end

  defp create_accord(_) do
    accord = fixture(:accord)
    {:ok, accord: accord}
  end
end
