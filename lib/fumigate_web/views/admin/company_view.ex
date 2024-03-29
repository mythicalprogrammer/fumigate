defmodule FumigateWeb.Admin.CompanyView do
  use FumigateWeb, :view

  def country_select_options(countries) do
    for country <- countries, do: {country.name, country.id}
  end

  def company_main_activity_select_options(company_main_activities) do
    for company_main_activity <- company_main_activities, do: {company_main_activity.main_activity, company_main_activity.id}
  end
end
