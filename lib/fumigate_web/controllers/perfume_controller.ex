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
              |> Fumigate.Repo.preload([
                :accords, 
                :companies,
                perfume_note_joins: :note  
              ])
    render(conn, "show.html", perfume: perfume)
  end
end
