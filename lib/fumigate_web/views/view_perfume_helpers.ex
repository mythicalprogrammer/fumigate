defmodule FumigateWeb.ViewPerfumeHelpers do
  use FumigateWeb, :view_perfume

  def note_select_options(notes) do
    for note <- notes, do: {note.note_name, note.id}
  end

  def accord_select_options(accords) do
    for accord <- accords, do: {accord.accord_name, accord.id}
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

  def note_parse(notejoins, pyramid) do
    notejoins 
    |> Enum.filter(fn notejoin -> notejoin.pyramid_note == pyramid end)
    |> Enum.map( 
      fn notejoin -> 
        "<a href='/notes/#{notejoin.note.id}'>#{notejoin.note.note_name}</a>" 
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

  def company_selected(params) do
    check = Map.has_key?(params, :companies)
    if check do
      company_selected_aux(params[:companies]) 
    else
      nil
    end
  end

  defp company_selected_aux(nil) do
    nil
  end
  defp company_selected_aux(companies) do
    for company <- companies, do: company.id
  end

  def note_selected(params, pyramid) do
    check = Map.has_key?(params, :perfume_note_joins)
    if check do
      note_selected_aux(params[:perfume_note_joins], pyramid) 
    else
      nil
    end
  end

  defp note_selected_aux(nil, _pyramid) do
    nil
  end
  defp note_selected_aux(notejoins, pyramid) do
    notejoins 
    |> Enum.filter(fn notejoin -> notejoin.pyramid_note == pyramid end)
    |> Enum.map(fn notejoin -> notejoin.note.id end)
  end

  def accord_selected(params) do
    check = Map.has_key?(params, :accords)
    if check do
      accord_selected_aux(params[:accords]) 
    else
      nil
    end
  end

  defp accord_selected_aux(nil) do
    nil
  end
  defp accord_selected_aux(accords) do
    for accord <- accords, do: accord.id
  end
end
