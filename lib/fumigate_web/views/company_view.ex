defmodule FumigateWeb.CompanyView do
  use FumigateWeb, :view

  def country_select_options(countries) do
    for country <- countries, do: {country.name, country.id}
  end

  def company_select_options(companies) do
    for company <- companies, do: {company.company_name, company.id}
  end
end
