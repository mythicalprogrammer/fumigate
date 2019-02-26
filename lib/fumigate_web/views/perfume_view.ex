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
end
