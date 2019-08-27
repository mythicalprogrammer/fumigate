defmodule FumigateWeb.User.PerfumeView do
  use FumigateWeb, :view

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

end
