defmodule FumigateWeb.CompanyController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance

  def index(conn, params) do
    params = Map.put(params, :page_size, 25)
    page = Fragrance.list_companies_paginate(params) 
    render(conn, "index.html", page: page) 
  end

  def show(conn, %{"id" => id}) do
    company = Fragrance.get_company!(id) 
              |> Fumigate.Repo.preload([:parent_company, :country, :company_main_activity])
    perfumes = Fragrance.get_perfumes_by_company_id(id) 
    render(conn, "show.html", company: company, perfumes: perfumes)
  end

end
