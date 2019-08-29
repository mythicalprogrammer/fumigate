defmodule FumigateWeb.Admin.PerfumeApprovalController do
  use FumigateWeb, :controller

  alias Fumigate.Approval
  alias Fumigate.Fragrance

  plug Fumigate.Plug.AccordList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.NoteList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.CompanyList when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    params = Map.put(params, :page_size, 25)
    # to list everything
    #page = Approval.list_perfume_approvals_paginate(params) 
    page = Approval.list_perfume_approvals_only_approved_false_paginate(params) 
    render(conn, "index.html", page: page)
  end

  def show(conn, %{"id" => id}) do
    perfume = Approval.get_perfume!(id)
              |> Fumigate.Repo.preload([
                :accords, 
                :companies, 
                :users,
                perfume_approval_note_joins: :note  
              ])
    render(conn, "show.html", perfume: perfume)
  end

  def edit(conn, %{"id" => id}) do
    perfume = Approval.get_perfume!(id)
              |> Fumigate.Repo.preload([
                :perfume_approval_company_joins, 
                :perfume_approval_accord_joins,
                :companies,
                :accords,
                perfume_approval_note_joins: :note  
              ])
    changeset = Approval.change_perfume(perfume)
    render(conn, "edit.html", 
           perfume: perfume, 
           changeset: changeset)
  end

  def update(conn, %{"id" => id, "perfume_approval" => perfume_params}) do
    perfume = Approval.get_perfume!(id)
              |> Fumigate.Repo.preload([
                :perfume_approval_company_joins, 
                :perfume_approval_accord_joins,
                :companies,
                :accords,
                perfume_approval_note_joins: :note  
              ])

    perfume_dupe = 
      Approval.find_perfume_approval_by_name_con_comp_sex(
        perfume_params["perfume_name"], 
        perfume_params["concentration"],
        perfume_params["company_id"],
        perfume_params["gender"])

    if perfume_dupe == false do 
      case Approval.update_perfume(perfume, perfume_params) do
        {:ok, perfume} ->
          conn
          |> put_flash(:info, "Perfume Approval updated successfully.")
          |> redirect(to: Routes.admin_perfume_approval_path(conn, :show, perfume))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", perfume: perfume, changeset: changeset)
      end
    else
      conn
      |> put_flash(:warning, "ERROR: Perfume Approval is a dupe.")
      |> redirect(to: Routes.admin_perfume_approval_path(conn, :show, perfume))
    end
  end

  def new(conn, %{"id" => id}) do
    perfume_approval = Approval.get_perfume!(id) 
                       |> Fumigate.Repo.preload([:companies,
                                                 :accords, 
                                                 :users,
                                                 perfume_approval_note_joins: :note
                                              ])

    dupe = 
      Fragrance.find_perfume_by_name_con_comp_sex(
        perfume_approval.perfume_name, 
        perfume_approval.concentration,
        perfume_approval.companies,
        perfume_approval.gender)

    if dupe == false do
      case Approval.approve_perfume(perfume_approval) do
        {:ok, new_perfume} ->

          {:ok, _perfume} = 
            Approval.update_perfume_approval_no_assoc(perfume_approval, %{approved: true})

          conn
          |> put_flash(:success, "Perfume created successfully.")
          |> redirect(to: Routes.admin_perfume_path(conn, :show, new_perfume))

        {:error, changeset } ->
          conn
          |> put_flash(:danger, "ERROR: Perfume created unsuccessfully.")
          |> render("show.html", perfume: perfume_approval)
      end
    else 
      # dupe or no company
      conn
      |> put_flash(:warning, "ERROR: Perfume to be approve is a dupe or there is no companies associated to it.")
      |> render("show.html", perfume: perfume_approval)
    end
  end
end
