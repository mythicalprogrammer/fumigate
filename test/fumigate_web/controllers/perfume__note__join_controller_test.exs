defmodule FumigateWeb.Perfume_Note_JoinControllerTest do
  use FumigateWeb.ConnCase

  alias Fumigate.Fragrance

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:perfume__note__join) do
    {:ok, perfume__note__join} = Fragrance.create_perfume__note__join(@create_attrs)
    perfume__note__join
  end

  describe "index" do
    test "lists all perfume_note_joins", %{conn: conn} do
      conn = get(conn, Routes.perfume__note__join_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Perfume note joins"
    end
  end

  describe "new perfume__note__join" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.perfume__note__join_path(conn, :new))
      assert html_response(conn, 200) =~ "New Perfume  note  join"
    end
  end

  describe "create perfume__note__join" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.perfume__note__join_path(conn, :create), perfume__note__join: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.perfume__note__join_path(conn, :show, id)

      conn = get(conn, Routes.perfume__note__join_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Perfume  note  join"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.perfume__note__join_path(conn, :create), perfume__note__join: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Perfume  note  join"
    end
  end

  describe "edit perfume__note__join" do
    setup [:create_perfume__note__join]

    test "renders form for editing chosen perfume__note__join", %{conn: conn, perfume__note__join: perfume__note__join} do
      conn = get(conn, Routes.perfume__note__join_path(conn, :edit, perfume__note__join))
      assert html_response(conn, 200) =~ "Edit Perfume  note  join"
    end
  end

  describe "update perfume__note__join" do
    setup [:create_perfume__note__join]

    test "redirects when data is valid", %{conn: conn, perfume__note__join: perfume__note__join} do
      conn = put(conn, Routes.perfume__note__join_path(conn, :update, perfume__note__join), perfume__note__join: @update_attrs)
      assert redirected_to(conn) == Routes.perfume__note__join_path(conn, :show, perfume__note__join)

      conn = get(conn, Routes.perfume__note__join_path(conn, :show, perfume__note__join))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, perfume__note__join: perfume__note__join} do
      conn = put(conn, Routes.perfume__note__join_path(conn, :update, perfume__note__join), perfume__note__join: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Perfume  note  join"
    end
  end

  describe "delete perfume__note__join" do
    setup [:create_perfume__note__join]

    test "deletes chosen perfume__note__join", %{conn: conn, perfume__note__join: perfume__note__join} do
      conn = delete(conn, Routes.perfume__note__join_path(conn, :delete, perfume__note__join))
      assert redirected_to(conn) == Routes.perfume__note__join_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.perfume__note__join_path(conn, :show, perfume__note__join))
      end
    end
  end

  defp create_perfume__note__join(_) do
    perfume__note__join = fixture(:perfume__note__join)
    {:ok, perfume__note__join: perfume__note__join}
  end
end
