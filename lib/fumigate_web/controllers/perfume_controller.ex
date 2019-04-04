defmodule FumigateWeb.PerfumeController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance

  def index(conn, params) do
    params = Map.put(params, :page_size, 25)
    page = Fragrance.list_perfumes_paginate(params) 
    render(conn, "index.html", page: page)
  end

  def show(conn, %{"id" => id}) do
    perfume = Fragrance.get_perfume!(id)
              |> Fumigate.Repo.preload([:accords, :companies])
    top_notes = Fragrance.get_all_top_notes_by_perfume_id(id)
    middle_notes = Fragrance.get_all_middle_notes_by_perfume_id(id)
    base_notes = Fragrance.get_all_base_notes_by_perfume_id(id)
    render(conn, "show.html", perfume: perfume,
           top_notes: top_notes, middle_notes: middle_notes, base_notes: base_notes)
  end
end
