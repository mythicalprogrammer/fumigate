defmodule FumigateWeb.Admin.PerfumeController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Perfume

  plug Fumigate.Plug.AccordList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.NoteList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.CompanyList when action in [:new, :create, :edit, :update]

  @perfume_struct %Perfume{
    companies: [],
    accords: [],
    perfume_note_joins: []
  }

  def index(conn, params) do 
    params = Map.put(params, :page_size, 25)
    page = Fragrance.list_perfumes_paginate(params) 
    render(conn, "index.html", page: page)
  end

  def new(conn, _params) do
    changeset = Fragrance.change_perfume(%Perfume{}) 
    render(conn, "new.html", changeset: changeset,
           perfume: @perfume_struct)
  end

  def create(conn, %{"perfume" => perfume_params}) do
    {perfume_dupe, _perfume_dupe_id} = 
      Fragrance.find_perfume_by_name_con_comp_sex(
        perfume_params["perfume_name"], 
        perfume_params["concentration"],
        perfume_params["company_id"],
        perfume_params["gender"])

    if perfume_dupe == false do 
      case Fragrance.create_perfume(perfume_params) do
        {:ok, perfume} ->
          conn
          |> put_flash(:info, "Perfume created successfully.")
          |> redirect(to: Routes.admin_perfume_path(conn, :show, perfume))

        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset, perfume: @perfume_struct)
      end
    else 
      changeset = Fragrance.Perfume.changeset(%Perfume{}, perfume_params) 
      conn
      |> put_flash(:warning, "ERROR: Perfume is a dupe.")
      |> render("new.html", changeset: changeset, perfume: @perfume_struct)
    end
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

  def edit(conn, %{"id" => id}) do
    perfume = Fragrance.get_perfume!(id)
              |> Fumigate.Repo.preload([
                :perfume_company_joins, 
                :perfume_accord_joins,
                :companies,
                :accords,
                perfume_note_joins: :note
              ])
    changeset = Fragrance.change_perfume(perfume)
    render(conn, 
           "edit.html", 
           perfume: perfume, 
           changeset: changeset)
  end

  def update(conn, %{"id" => id, "perfume" => perfume_params}) do
    perfume = Fragrance.get_perfume!(id)
              |> Fumigate.Repo.preload([
                :perfume_company_joins, 
                :perfume_accord_joins,
                :companies,
                :accords,
                perfume_note_joins: :note
              ])

    {perfume_dupe, perfume_dupe_id} = 
      Fragrance.find_perfume_by_name_con_comp_sex(
        perfume_params["perfume_name"], 
        perfume_params["concentration"],
        perfume_params["company_id"],
        perfume_params["gender"])

    perfume_dupe_id = List.first(perfume_dupe_id)
    
    if (perfume_dupe == false) 
      || (perfume_dupe_id == String.to_integer(id)) do 
      case Fragrance.update_perfume(perfume, perfume_params) do
        {:ok, perfume} ->
          conn
          |> put_flash(:info, "Perfume updated successfully.")
          |> redirect(to: Routes.admin_perfume_path(conn, :show, perfume))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", changeset: changeset, perfume: perfume)
      end
    else
      conn
      |> put_flash(:warning, "ERROR: Perfume is a dupe.")
      |> redirect(to: Routes.admin_perfume_path(conn, :show, perfume))
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
