defmodule FumigateWeb.NoteController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance

  def index(conn, params) do
    params = Map.put(params, :page_size, 25)
    page = Fragrance.list_notes_paginate(params) 
    render(conn, "index.html", page: page) 
  end

  def show(conn, %{"id" => id}) do
    note = Fragrance.get_note!(id)
    render(conn, "show.html", note: note)
  end
end
