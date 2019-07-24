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
    render(conn, "show.html", perfume: perfume,
           top_notes: top_notes, middle_notes: middle_notes, base_notes: base_notes)
  end

  def edit(conn, %{"id" => id}) do
    perfume = Approval.get_perfume!(id)
    changeset = Approval.change_perfume(perfume)
    companies_select = Approval.select_all_companies_by_perfume_id(perfume.id)
    accords_select = Approval.select_all_accords_by_perfume_id(perfume.id)
    top_notes_select = Approval.select_all_top_notes_by_perfume_id(perfume.id)
    middle_notes_select = Approval.select_all_middle_notes_by_perfume_id(perfume.id)
    base_notes_select = Approval.select_all_base_notes_by_perfume_id(perfume.id)
    render(conn, "edit.html", perfume: perfume, changeset: changeset, 
           accords_select: accords_select, 
           top_notes_select: top_notes_select, 
           middle_notes_select: middle_notes_select,
           base_notes_select: base_notes_select, 
           companies_select: companies_select)
  end

  def update(conn, %{"id" => id, "perfume_approval" => perfume_params}) do
    perfume = Approval.get_perfume!(id)

    case Approval.update_perfume(perfume, perfume_params) do
      {:ok, perfume} ->
        if perfume_params["company_id"] == nil do
          Approval.delete_all_company_joins_by_perfume_id(id)
        end
        if perfume_params["company_id"] != nil do
          Approval.delete_all_company_joins_by_perfume_id(id)
          perfume_params["company_id"] 
          |> Approval.insert_all_companies(perfume.id)
        end
        if perfume_params["top_note_id"] == nil do
          Approval.delete_all_note_joins_by_perfume_id(perfume.id, "top")
        end
        if perfume_params["middle_note_id"] == nil do
          Approval.delete_all_note_joins_by_perfume_id(perfume.id, "middle")
        end
        if perfume_params["base_note_id"] == nil do
          Approval.delete_all_note_joins_by_perfume_id(perfume.id, "base")
        end
        if perfume_params["top_note_id"] != nil do
          Approval.delete_all_note_joins_by_perfume_id(perfume.id, "top")
          perfume_params["top_note_id"] 
          |> Approval.insert_all_notes_by_perfume_id(perfume.id,"top")
        end
        if perfume_params["middle_note_id"] != nil do
          Approval.delete_all_note_joins_by_perfume_id(perfume.id, "middle")
          perfume_params["middle_note_id"] 
          |> Approval.insert_all_notes_by_perfume_id(perfume.id,"middle")
        end
        if perfume_params["base_note_id"] != nil do
          Approval.delete_all_note_joins_by_perfume_id(perfume.id, "base")
          perfume_params["base_note_id"] 
          |> Approval.insert_all_notes_by_perfume_id(perfume.id,"base")
        end
        if perfume_params["accord_id"] == nil do
          Approval.delete_all_accord_joins_by_perfume_id(perfume.id)
        end
        if perfume_params["accord_id"] != nil do
          Approval.delete_all_accord_joins_by_perfume_id(perfume.id)
          perfume_params["accord_id"] 
          |> Approval.insert_all_accords(perfume)
        end
        conn
        |> put_flash(:info, "Perfume updated successfully.")
        |> redirect(to: Routes.admin_perfume_approval_path(conn, :show, perfume))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", perfume: perfume, changeset: changeset)
    end
  end

  #def delete(conn, %{"id" => id}) do
  #  perfume = Fragrance.get_perfume!(id)
  #  {:ok, _perfume} = Fragrance.delete_perfume(perfume)
  #
  #  conn
  #  |> put_flash(:info, "Perfume deleted successfully.")
  #  |> redirect(to: Routes.admin_perfume_path(conn, :index))
  #end
end
