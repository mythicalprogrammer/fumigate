defmodule FumigateWeb.PerfumeControllerTest do
  use FumigateWeb.ConnCase

  alias Fumigate.Fragrance

  @create_attrs %{concentration: "some concentration", day_released: 42, gender: "some gender", month_released: 42, perfume_description: "some perfume_description", perfume_name: "some perfume_name", picture_url: "some picture_url", year_released: 42}
  @update_attrs %{concentration: "some updated concentration", day_released: 43, gender: "some updated gender", month_released: 43, perfume_description: "some updated perfume_description", perfume_name: "some updated perfume_name", picture_url: "some updated picture_url", year_released: 43}
  @invalid_attrs %{concentration: nil, day_released: nil, gender: nil, month_released: nil, perfume_description: nil, perfume_name: nil, picture_url: nil, year_released: nil}

  def fixture(:perfume) do
    {:ok, perfume} = Fragrance.create_perfume(@create_attrs)
    perfume
  end

  describe "index" do
    test "lists all perfumes", %{conn: conn} do
      conn = get(conn, Routes.perfume_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Perfumes"
    end
  end

  describe "new perfume" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.perfume_path(conn, :new))
      assert html_response(conn, 200) =~ "New Perfume"
    end
  end

  describe "create perfume" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.perfume_path(conn, :create), perfume: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.perfume_path(conn, :show, id)

      conn = get(conn, Routes.perfume_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Perfume"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.perfume_path(conn, :create), perfume: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Perfume"
    end
  end

  describe "edit perfume" do
    setup [:create_perfume]

    test "renders form for editing chosen perfume", %{conn: conn, perfume: perfume} do
      conn = get(conn, Routes.perfume_path(conn, :edit, perfume))
      assert html_response(conn, 200) =~ "Edit Perfume"
    end
  end

  describe "update perfume" do
    setup [:create_perfume]

    test "redirects when data is valid", %{conn: conn, perfume: perfume} do
      conn = put(conn, Routes.perfume_path(conn, :update, perfume), perfume: @update_attrs)
      assert redirected_to(conn) == Routes.perfume_path(conn, :show, perfume)

      conn = get(conn, Routes.perfume_path(conn, :show, perfume))
      assert html_response(conn, 200) =~ "some updated concentration"
    end

    test "renders errors when data is invalid", %{conn: conn, perfume: perfume} do
      conn = put(conn, Routes.perfume_path(conn, :update, perfume), perfume: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Perfume"
    end
  end

  describe "delete perfume" do
    setup [:create_perfume]

    test "deletes chosen perfume", %{conn: conn, perfume: perfume} do
      conn = delete(conn, Routes.perfume_path(conn, :delete, perfume))
      assert redirected_to(conn) == Routes.perfume_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.perfume_path(conn, :show, perfume))
      end
    end
  end

  defp create_perfume(_) do
    perfume = fixture(:perfume)
    {:ok, perfume: perfume}
  end
end
