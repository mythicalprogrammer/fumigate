defmodule FumigateWeb.Admin.CompanyController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Company

  plug :load_countries when action in [:new, :create, :edit, :update]
  plug Fumigate.CompanyList when action in [:new, :create, :edit, :update]
  plug :load_company_main_activities when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    page = Fragrance.list_companies_paginate(params) 
    render(conn, "index.html", page: page) 
  end

  def new(conn, _params) do
    changeset = Fragrance.change_company(%Company{
      country: %Fragrance.Country{}
    })
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    case Fragrance.create_company(company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.admin_company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Fragrance.get_company!(id) 
              |> Fumigate.Repo.preload([:parent_company, :country, :company_main_activity])
    perfumes = Fragrance.get_perfumes_by_company_id(id) 
    render(conn, "show.html", company: company, perfumes: perfumes)
  end

  def edit(conn, %{"id" => id}) do
    company = Fragrance.get_company!(id)
    changeset = Fragrance.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Fragrance.get_company!(id)

    case Fragrance.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.admin_company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Fragrance.get_company!(id)
    {:ok, _company} = Fragrance.delete_company(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
    |> redirect(to: Routes.admin_company_path(conn, :index))
  end
  
  defp load_countries(conn, _) do
    assign(conn, :countries, Fragrance.list_alphabetical_countries())
  end

  defp load_company_main_activities(conn, _) do
    assign(conn, :company_main_activities, Fragrance.list_alphabetical_company_main_activities())
  end
end
