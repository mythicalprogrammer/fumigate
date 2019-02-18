defmodule FumigateWeb.Perfume_Company_JoinView do
  use FumigateWeb, :view

  def company_select_options(companies) do
    for company <- companies, do: {company.company_name, company.id}
  end

  def perfume_select_options(perfumes) do
    for perfume <- perfumes, do: {perfume.perfume_name, perfume.id}
  end
end
