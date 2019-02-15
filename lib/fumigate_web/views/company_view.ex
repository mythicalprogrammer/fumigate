defmodule FumigateWeb.CompanyView do
  use FumigateWeb, :view

  def country_select_options(countries) do
    for country <- countries, do: {country.name, country.id}
  end
end
