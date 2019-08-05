defmodule FumigateWeb.Admin.PerfumeController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Perfume

  plug Fumigate.Plug.AccordList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.NoteList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.CompanyList when action in [:new, :create, :edit, :update]

  def index(conn, params) do 
    params = Map.put(params, :page_size, 25)
    page = Fragrance.list_perfumes_paginate(params) 
    render(conn, "index.html", page: page)
  end

  def new(conn, _params) do
    changeset = Fragrance.change_perfume(%Perfume{}) 
    render(conn, "new.html", changeset: changeset,
           accords_select: nil, 
           top_notes_select: nil, 
           middle_notes_select: nil,
           base_notes_select: nil, 
           companies_select: nil)
  end

  def create(conn, %{"perfume" => perfume_params}) do

    perfume_dupe = 
      Fragrance.find_perfume_by_name_con_comp(perfume_params["perfume_name"], 
                                              perfume_params["concentration"],
                                              perfume_params["company"])

    if List.first(perfume_dupe) == nil do 
      case Fragrance.create_perfume(perfume_params) do
        {:ok, perfume} ->
          conn
          |> put_flash(:info, "Perfume created successfully.")
          |> redirect(to: Routes.admin_perfume_path(conn, :show, perfume))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset,
            accords_select: nil, 
            top_notes_select: nil, 
            middle_notes_select: nil,
            base_notes_select: nil, 
            companies_select: nil)
      end
    else 
      changeset = Fragrance.Perfume.changeset(%Perfume{}, perfume_params) 
      conn
      |> put_flash(:warning, "ERROR: Perfume is a dupe.")
      |> render("new.html", changeset: changeset,
            accords_select: nil, 
            top_notes_select: nil, 
            middle_notes_select: nil,
            base_notes_select: nil, 
            companies_select: nil)
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
              |> Fumigate.Repo.preload([
                :perfume_company_joins, :perfume_note_joins, :perfume_accord_joins])
    changeset = Fragrance.change_perfume(perfume)
    companies_select = Fragrance.select_all_companies_by_perfume_id(perfume.id)
    accords_select = Fragrance.select_all_accords_by_perfume_id(perfume.id)
    top_notes_select = Fragrance.select_all_top_notes_by_perfume_id(perfume.id)
    middle_notes_select = Fragrance.select_all_middle_notes_by_perfume_id(perfume.id)
    base_notes_select = Fragrance.select_all_base_notes_by_perfume_id(perfume.id)
    render(conn, "edit.html", perfume: perfume, changeset: changeset, 
           accords_select: accords_select, 
           top_notes_select: top_notes_select, 
           middle_notes_select: middle_notes_select,
           base_notes_select: base_notes_select, 
           companies_select: companies_select)
  end

  def update(conn, %{"id" => id, "perfume" => perfume_params}) do
    perfume = Fragrance.get_perfume!(id)
              |> Fumigate.Repo.preload([
                :perfume_company_joins, :perfume_note_joins, :perfume_accord_joins])

    case Fragrance.update_perfume(perfume, perfume_params) do
      {:ok, perfume} ->
        conn
        |> put_flash(:info, "Perfume updated successfully.")
        |> redirect(to: Routes.admin_perfume_path(conn, :show, perfume))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", perfume: perfume, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    perfume = Fragrance.get_perfume!(id)
    {:ok, _perfume} = Fragrance.delete_perfume(perfume)

    conn
    |> put_flash(:info, "Perfume deleted successfully.")
    |> redirect(to: Routes.admin_perfume_path(conn, :index))
  end
end
