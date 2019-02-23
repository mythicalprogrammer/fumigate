defmodule FumigateWeb.Perfume_Note_JoinView do
  use FumigateWeb, :view

  def note_select_options(notes) do
    for note <- notes, do: {note.note_name, note.id}
  end

  def perfume_select_options(perfumes) do
    for perfume <- perfumes, do: {perfume.perfume_name, perfume.id}
  end
end
