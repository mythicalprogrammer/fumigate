defmodule FumigateWeb.PerfumeView do
  use FumigateWeb, :view

  def company_select_options(companies) do
    for company <- companies, do: {company.company_name, company.id}
  end

  def note_select_options(notes) do
    for note <- notes, do: {note.note_name, note.id}
  end

  def accord_select_options(accords) do
    for accord <- accords, do: {accord.accord_name, accord.id}
  end

  def company_parse(companies) do
    companies
    |> Enum.map( 
         fn company -> "<a href='/companies/'#{company.id}>#{company.company_name}</a>" 
    end)
    |> Enum.join(", ")
    |> raw 
  end
end
