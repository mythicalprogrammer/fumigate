defmodule FumigateWeb.User.PerfumeController do
  use FumigateWeb, :controller

  alias Fumigate.Approval
  alias Fumigate.Approval.PerfumeApproval

  plug Fumigate.Plug.AccordList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.NoteList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.CompanyList when action in [:new, :create, :edit, :update]

  #def index(conn, params) do
    # get user
    #  params = Map.put(params, :page_size, 25)
    # list perfume_approvals with user_id created
    #  page = Fragrance.list_perfumes_paginate(params) 
    # render(conn, "index.html", page: page)
    #end

  def new(conn, _params) do
    changeset = Approval.change_perfume_approval(%PerfumeApproval{})
    render(conn, "new.html", changeset: changeset,
           accords_select: nil, 
           top_notes_select: nil, 
           middle_notes_select: nil,
           base_notes_select: nil, 
           companies_select: nil)
  end

  def create(conn, %{"perfume_approval" => perfume_params}) do
    case Approval.create_perfume_approval(perfume_params) do
      {:ok, _perfume} ->
        conn
        |> put_flash(:info, "Perfume created successfully.")
        |> redirect(to: Routes.perfume_path(conn, :index))
  #      |> redirect(to: Routes.admin_perfume_path(conn, :show, perfume))
  
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset,
          accords_select: nil, 
          top_notes_select: nil, 
          middle_notes_select: nil,
          base_notes_select: nil, 
          companies_select: nil)
    end
  end

  #def show(conn, %{"id" => id}) do
  #  perfume = Fragrance.get_perfume_approval!(id)
  #            |> Fumigate.Repo.preload([:accords, :companies])
  #  top_notes = Fragrance.get_all_top_notes_by_perfume_approval_id(id)
  #  middle_notes = Fragrance.get_all_middle_notes_by_perfume_approval_id(id)
  #  base_notes = Fragrance.get_all_base_notes_by_perfume_approval_id(id)
  #  render(conn, "show.html", perfume: perfume,
  #         top_notes: top_notes, middle_notes: middle_notes, base_notes: base_notes)
  #end
end
