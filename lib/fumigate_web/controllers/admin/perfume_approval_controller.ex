defmodule FumigateWeb.Admin.PerfumeApprovalController do
  use FumigateWeb, :controller

  alias Fumigate.Approval

  plug Fumigate.Plug.AccordList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.NoteList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.CompanyList when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    params = Map.put(params, :page_size, 25)
    page = Approval.list_perfume_approvals_paginate(params) 
    render(conn, "index.html", page: page)
  end

  def show(conn, %{"id" => id}) do
    perfume = Approval.get_perfume!(id)
              |> Fumigate.Repo.preload([:accords, :companies])
    top_notes = Approval.get_all_top_notes_by_perfume_id(id)
    middle_notes = Approval.get_all_middle_notes_by_perfume_id(id)
    base_notes = Approval.get_all_base_notes_by_perfume_id(id)
    #render(conn, "show.html", perfume: perfume)
           render(conn, "show.html", perfume: perfume,
           top_notes: top_notes, middle_notes: middle_notes, base_notes: base_notes)
  end
end
