defmodule FumigateWeb.Admin.PerfumeApprovalController do
  use FumigateWeb, :controller

  alias Fumigate.Approval
  alias Fumigate.Fragrance

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
    render(conn, "show.html", perfume: perfume,
           top_notes: top_notes, middle_notes: middle_notes, base_notes: base_notes)
  end

  def edit(conn, %{"id" => id}) do
    perfume = Approval.get_perfume!(id)
              |> Fumigate.Repo.preload([
                :perfume_approval_company_joins, 
                :perfume_approval_note_joins, 
                :perfume_approval_accord_joins,
                :companies,
                :accords
              ])
    changeset = Approval.change_perfume(perfume)
    top_notes_select = Approval.select_all_top_notes_by_perfume_id(perfume.id)
    middle_notes_select = Approval.select_all_middle_notes_by_perfume_id(perfume.id)
    base_notes_select = Approval.select_all_base_notes_by_perfume_id(perfume.id)
    render(conn, "edit.html", 
           perfume: perfume, 
           changeset: changeset, 
           top_notes_select: top_notes_select, 
           middle_notes_select: middle_notes_select,
           base_notes_select: base_notes_select)
           
  end

  def update(conn, %{"id" => id, "perfume_approval" => perfume_params}) do
    perfume = Approval.get_perfume!(id)
              |> Fumigate.Repo.preload([
                :perfume_approval_company_joins, 
                :perfume_approval_note_joins, 
                :perfume_approval_accord_joins])

    case Approval.update_perfume(perfume, perfume_params) do
      {:ok, perfume} ->
        conn
        |> put_flash(:info, "Perfume updated successfully.")
        |> redirect(to: Routes.admin_perfume_approval_path(conn, :show, perfume))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", perfume: perfume, changeset: changeset)
    end
  end

  def new(conn, %{"id" => id}) do
    perfume_approval = Approval.get_perfume!(id) 
                       |> Fumigate.Repo.preload([:companies, :accords, 
                                                 :perfume_approval_note_joins])

    perfume = Approval.find_perfume_by_name_con_comp(perfume_approval.perfume_name, 
                                                     perfume_approval.concentration,
                                                     perfume_approval.companies)

    if List.first(perfume) == nil && List.first(perfume_approval.companies) != nil do
      case Approval.approve_perfume(perfume_approval) do
        {:ok, new_perfume} ->
          # delete after successful transfer 
          {:ok, _perfume} = Approval.delete_perfume(perfume_approval)

          conn
          |> put_flash(:success, "Perfume created successfully.")
          |> redirect(to: Routes.admin_perfume_path(conn, :show, new_perfume))

        {:error, _changeset } ->
          top_notes = Approval.get_all_top_notes_by_perfume_id(id)
          middle_notes = Approval.get_all_middle_notes_by_perfume_id(id)
          base_notes = Approval.get_all_base_notes_by_perfume_id(id)
          conn
          |> put_flash(:danger, "ERROR: Perfume created unsuccessfully.")
          |> render("show.html", perfume: perfume_approval,
               top_notes: top_notes, middle_notes: middle_notes, base_notes: base_notes)
      end
    else 
      # dupe or no company
      top_notes = Approval.get_all_top_notes_by_perfume_id(id)
      middle_notes = Approval.get_all_middle_notes_by_perfume_id(id)
      base_notes = Approval.get_all_base_notes_by_perfume_id(id)
      conn
      |> put_flash(:warning, "ERROR: Perfume to be approve is a dupe or there is no companies associated to it.")
      |> render("show.html", perfume: perfume_approval,
         top_notes: top_notes, middle_notes: middle_notes, base_notes: base_notes)
    end
  end
end
