defmodule FumigateWeb.CompanyControllerTest do
  use FumigateWeb.ConnCase

  alias Fumigate.Fragrance

  @create_attrs %{company_description: "some company_description", company_name: "some company_name", company_url: "some company_url", day_established: 42, logo_url: "some logo_url", month_established: 42, year_established: 42}
  @update_attrs %{company_description: "some updated company_description", company_name: "some updated company_name", company_url: "some updated company_url", day_established: 43, logo_url: "some updated logo_url", month_established: 43, year_established: 43}
  @invalid_attrs %{company_description: nil, company_name: nil, company_url: nil, day_established: nil, logo_url: nil, month_established: nil, year_established: nil}

  def fixture(:company) do
    {:ok, company} = Fragrance.create_company(@create_attrs)
    company
  end

  describe "index" do
    test "lists all companies", %{conn: conn} do
      conn = get(conn, Routes.company_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Companies"
    end
  end

  describe "new company" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.company_path(conn, :new))
      assert html_response(conn, 200) =~ "New Company"
    end
  end

  describe "create company" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.company_path(conn, :create), company: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.company_path(conn, :show, id)

      conn = get(conn, Routes.company_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Company"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.company_path(conn, :create), company: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Company"
    end
  end

  describe "edit company" do
    setup [:create_company]

    test "renders form for editing chosen company", %{conn: conn, company: company} do
      conn = get(conn, Routes.company_path(conn, :edit, company))
      assert html_response(conn, 200) =~ "Edit Company"
    end
  end

  describe "update company" do
    setup [:create_company]

    test "redirects when data is valid", %{conn: conn, company: company} do
      conn = put(conn, Routes.company_path(conn, :update, company), company: @update_attrs)
      assert redirected_to(conn) == Routes.company_path(conn, :show, company)

      conn = get(conn, Routes.company_path(conn, :show, company))
      assert html_response(conn, 200) =~ "some updated company_description"
    end

    test "renders errors when data is invalid", %{conn: conn, company: company} do
      conn = put(conn, Routes.company_path(conn, :update, company), company: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Company"
    end
  end

  describe "delete company" do
    setup [:create_company]

    test "deletes chosen company", %{conn: conn, company: company} do
      conn = delete(conn, Routes.company_path(conn, :delete, company))
      assert redirected_to(conn) == Routes.company_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.company_path(conn, :show, company))
      end
    end
  end

  defp create_company(_) do
    company = fixture(:company)
    {:ok, company: company}
  end
end
