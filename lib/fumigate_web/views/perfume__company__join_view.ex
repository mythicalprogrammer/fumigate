defmodule FumigateWeb.Perfume_Company_JoinView do
  use FumigateWeb, :view

  def company_select_options(companies) do
    for company <- companies, do: {company.company_name, company.id}
  end
end
