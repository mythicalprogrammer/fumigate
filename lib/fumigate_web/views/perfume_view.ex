defmodule FumigateWeb.PerfumeView do
  use FumigateWeb, :view

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
