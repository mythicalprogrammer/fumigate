defmodule FumigateWeb.PerfumeController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Perfume

  plug Fumigate.AccordList when action in [:new, :create, :edit, :update]
  plug Fumigate.NoteList when action in [:new, :create, :edit, :update]
  plug Fumigate.CompanyList when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    perfumes = Fragrance.list_perfumes_paginate(params) 
    render(conn, "index.html", perfumes: perfumes.entries, page: perfumes.page_number)
  end

  def new(conn, _params) do
    changeset = Fragrance.change_perfume(%Perfume{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"perfume" => perfume_params}) do
    case Fragrance.create_perfume(perfume_params) do
      {:ok, perfume} ->
        conn
        |> put_flash(:info, "Perfume created successfully.")
        |> redirect(to: Routes.perfume_path(conn, :show, perfume))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
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

  def edit(conn, %{"id" => id}) do
    perfume = Fragrance.get_perfume!(id)
    changeset = Fragrance.change_perfume(perfume)
    companies_select = Fragrance.select_all_companies_by_perfume_id(perfume.id)
    accords_select = Fragrance.select_all_accords_by_perfume_id(perfume.id)
    top_notes_select = Fragrance.select_all_top_notes_by_perfume_id(perfume.id)
    middle_notes_select = Fragrance.select_all_middle_notes_by_perfume_id(perfume.id)
    base_notes_select = Fragrance.select_all_base_notes_by_perfume_id(perfume.id)
    render(conn, "edit.html", perfume: perfume, changeset: changeset, accords_select: accords_select, 
           top_notes_select: top_notes_select, middle_notes_select: middle_notes_select,
           base_notes_select: base_notes_select, 
           companies_select: companies_select)
  end

  def update(conn, %{"id" => id, "perfume" => perfume_params}) do
    perfume = Fragrance.get_perfume!(id)

    case Fragrance.update_perfume(perfume, perfume_params) do
      {:ok, perfume} ->
        if perfume_params["company_id"] == nil do
          Fragrance.delete_all_company_joins_by_perfume_id(id)
        end
        if perfume_params["company_id"] != nil do
          Fragrance.delete_all_company_joins_by_perfume_id(id)
          perfume_params["company_id"] 
          |> Fragrance.insert_all_companies(perfume.id)
        end
        if perfume_params["top_note_id"] == nil do
          Fragrance.delete_all_note_joins_by_perfume_id(perfume.id, "top")
        end
        if perfume_params["middle_note_id"] == nil do
          Fragrance.delete_all_note_joins_by_perfume_id(perfume.id, "middle")
        end
        if perfume_params["base_note_id"] == nil do
          Fragrance.delete_all_note_joins_by_perfume_id(perfume.id, "base")
        end
        if perfume_params["top_note_id"] != nil do
          Fragrance.delete_all_note_joins_by_perfume_id(perfume.id, "top")
          perfume_params["top_note_id"] 
          |> Fragrance.insert_all_notes_by_perfume_id(perfume.id,"top")
        end
        if perfume_params["middle_note_id"] != nil do
          Fragrance.delete_all_note_joins_by_perfume_id(perfume.id, "middle")
          perfume_params["middle_note_id"] 
          |> Fragrance.insert_all_notes_by_perfume_id(perfume.id,"middle")
        end
        if perfume_params["base_note_id"] != nil do
          Fragrance.delete_all_note_joins_by_perfume_id(perfume.id, "base")
          perfume_params["base_note_id"] 
          |> Fragrance.insert_all_notes_by_perfume_id(perfume.id,"base")
        end
        if perfume_params["accord_id"] == nil do
          Fragrance.delete_all_accord_joins_by_perfume_id(perfume.id)
        end
        if perfume_params["accord_id"] != nil do
          Fragrance.delete_all_accord_joins_by_perfume_id(perfume.id)
          perfume_params["accord_id"] 
          |> Fragrance.insert_all_accords(perfume)
        end
        conn
        |> put_flash(:info, "Perfume updated successfully.")
        |> redirect(to: Routes.perfume_path(conn, :show, perfume))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", perfume: perfume, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    perfume = Fragrance.get_perfume!(id)
    {:ok, _perfume} = Fragrance.delete_perfume(perfume)

    conn
    |> put_flash(:info, "Perfume deleted successfully.")
    |> redirect(to: Routes.perfume_path(conn, :index))
  end
end
