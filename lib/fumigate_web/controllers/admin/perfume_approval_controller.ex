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
                :perfume_approval_accord_joins])
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
              |> Fumigate.Repo.preload([:accords, :companies, :notes])

    approval_perfume_name = perfume_approval.perfume_name
    approval_perfume_concentration = perfume_approval.concentration
    approval_perfume_companies = perfume_approval.companies

    perfume = Approval.find_perfume_by_name_con_comp(approval_perfume_name, 
                                                     approval_perfume_concentration,
                                                     approval_perfume_companies)
    perfume_approval_map = Map.from_struct(perfume_approval)

    if List.first(perfume) == nil && List.first(perfume_approval.companies) != nil do
      case Fragrance.create_perfume(perfume_approval_map) do
        {:ok, new_perfume} ->
          company_ids = Enum.map(perfume_approval.companies, fn company -> Integer.to_string(company.id) end)
		  if company_ids != nil do
			company_ids 
			|> Fragrance.insert_all_companies(new_perfume.id)
		  end
		  if Map.has_key?(perfume_approval_map, "top_note_id") && perfume_approval.top_note_id != nil do
			perfume_approval.top_note_id 
			|> Fragrance.insert_all_notes_by_perfume_id(new_perfume.id,"top")
		  end
		  if Map.has_key?(perfume_approval_map, "middle_note_id") && perfume_approval.middle_note_id != nil do
			perfume_approval.middle_note_id 
			|> Fragrance.insert_all_notes_by_perfume_id(new_perfume.id,"middle")
		  end
		  if Map.has_key?(perfume_approval_map, "base_note_id") && perfume_approval.base_note_id != nil do
			perfume_approval.base_note_id 
			|> Fragrance.insert_all_notes_by_perfume_id(new_perfume.id,"base")
		  end
		  if Map.has_key?(perfume_approval_map, "accord_id") && perfume_approval.accord_id != nil do
			perfume_approval.accord_id 
			|> Fragrance.insert_all_accords(new_perfume)
		  end
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
      # delete after successful transfer 
      {:ok, _perfume} = Approval.delete_perfume(perfume_approval)
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
