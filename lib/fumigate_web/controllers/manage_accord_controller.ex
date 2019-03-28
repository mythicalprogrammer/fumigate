defmodule FumigateWeb.ManageAccordController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Accord

  def index(conn, params) do
    page = Fragrance.list_accords_paginate(params) 
    render(conn, "index.html", page: page) 
  end

  def new(conn, _params) do
    changeset = Fragrance.change_accord(%Accord{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"accord" => accord_params}) do
    case Fragrance.create_accord(accord_params) do
      {:ok, accord} ->
        conn
        |> put_flash(:info, "Accord created successfully.")
        |> redirect(to: Routes.manage_accord_path(conn, :show, accord))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    accord = Fragrance.get_accord!(id)
    render(conn, "show.html", accord: accord)
  end

  def edit(conn, %{"id" => id}) do
    accord = Fragrance.get_accord!(id)
    changeset = Fragrance.change_accord(accord)
    render(conn, "edit.html", accord: accord, changeset: changeset)
  end

  def update(conn, %{"id" => id, "accord" => accord_params}) do
    accord = Fragrance.get_accord!(id)

    case Fragrance.update_accord(accord, accord_params) do
      {:ok, accord} ->
        conn
        |> put_flash(:info, "Accord updated successfully.")
        |> redirect(to: Routes.manage_accord_path(conn, :show, accord))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", accord: accord, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    accord = Fragrance.get_accord!(id)
    {:ok, _accord} = Fragrance.delete_accord(accord)

    conn
    |> put_flash(:info, "Accord deleted successfully.")
    |> redirect(to: Routes.manage_accord_path(conn, :index))
  end
end
