defmodule FumigateWeb.CompanyController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Company

  def index(conn, _params) do
    companies = Fragrance.list_companies()
    IO.inspect(Fragrance.get_company!(1))
    render(conn, "index.html", companies: companies)
  end

  def new(conn, _params) do
    changeset = Fragrance.change_company(%Company{
      countries: %Fragrance.Country{}
    })
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    case Fragrance.create_company(company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Fragrance.get_company!(id) 
              |> Fumigate.Repo.preload([:parent_company, :countries, :company_main_activities])
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = Fragrance.get_company!(id)
              |> Fumigate.Repo.preload([:parent_company, :countries, :company_main_activities])
    main_activities = Fragrance.list_company_main_activities()
    changeset = Fragrance.change_company(company)
    IO.inspect(changeset)
    render(conn, "edit.html", company: company, main_activities: main_activities, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Fragrance.get_company!(id)

    case Fragrance.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Fragrance.get_company!(id)
    {:ok, _company} = Fragrance.delete_company(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
    |> redirect(to: Routes.company_path(conn, :index))
  end
end
