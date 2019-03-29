defmodule FumigateWeb.ManageCompanyView do
  use FumigateWeb, :view

  def country_select_options(countries) do
    for country <- countries, do: {country.name, country.id}
  end

  def company_select_options(companies) do
    for company <- companies, do: {company.company_name, company.id}
  end

  def company_main_activity_select_options(company_main_activities) do
    for company_main_activity <- company_main_activities, do: {company_main_activity.main_activity, company_main_activity.id}
  end

  def country_name(%{country: %{name: name}}), do: name
  def country_name(_), do: "Unknown" 

  def main_activity(%{company_main_activity: %{main_activity: main_activity}}), do: main_activity 
  def main_activity(_), do: "Unknown" 
end
