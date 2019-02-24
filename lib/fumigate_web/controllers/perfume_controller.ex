defmodule FumigateWeb.PerfumeController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Perfume

  def index(conn, _params) do
    perfumes = Fragrance.list_perfumes()
    render(conn, "index.html", perfumes: perfumes)
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
              |> Fumigate.Repo.preload([:notes, :accords, :companies])
    render(conn, "show.html", perfume: perfume)
  end

  def edit(conn, %{"id" => id}) do
    perfume = Fragrance.get_perfume!(id)
    changeset = Fragrance.change_perfume(perfume)
    render(conn, "edit.html", perfume: perfume, changeset: changeset)
  end

  def update(conn, %{"id" => id, "perfume" => perfume_params}) do
    perfume = Fragrance.get_perfume!(id)

    case Fragrance.update_perfume(perfume, perfume_params) do
      {:ok, perfume} ->
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
