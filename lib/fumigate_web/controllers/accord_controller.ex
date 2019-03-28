defmodule FumigateWeb.AccordController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance

  def index(conn, params) do
    page = Fragrance.list_accords_paginate(params) 
    render(conn, "index.html", page: page) 
  end

  def show(conn, %{"id" => id}) do
    accord = Fragrance.get_accord!(id)
    render(conn, "show.html", accord: accord)
  end

end
