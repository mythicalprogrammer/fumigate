defmodule FumigateWeb.Admin.PerfumeApprovalView do
  use FumigateWeb, :view

  def company_select_options(companies) do
    for company <- companies, do: {company.company_name, company.id}
  end

  def company_selected(companies) do
    for company <- companies, do: company.id
  end

  def note_select_options(notes) do
    for note <- notes, do: {note.note_name, note.id}
  end

  def accord_select_options(accords) do
    for accord <- accords, do: {accord.accord_name, accord.id}
  end

  def accord_selected(accords) do
    for accord <- accords, do: accord.id
  end

  def company_parse(companies) do
    companies
    |> Enum.map( 
         fn company -> "<a href='/companies/#{company.id}'>#{company.company_name}</a>" 
    end)
    |> Enum.sort
    |> Enum.join(", ")
    |> HtmlSanitizeEx.basic_html 
    |> raw 
  end

  def note_parse(notes) do
    notes 
    |> Enum.map( 
         fn note -> "<a href='/notes/#{note.id}'>#{note.note_name}</a>" 
    end)
    |> Enum.sort
    |> Enum.join(", ")
    |> HtmlSanitizeEx.basic_html 
    |> raw 
  end

  def accord_parse(accords) do
    accords
    |> Enum.map( 
         fn accord -> "<a href='/accords/#{accord.id}'>#{accord.accord_name}</a>" 
    end)
    |> Enum.sort
    |> Enum.join(", ")
    |> HtmlSanitizeEx.basic_html 
    |> raw 
  end
end
