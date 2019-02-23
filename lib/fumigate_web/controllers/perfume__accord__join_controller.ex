defmodule FumigateWeb.Perfume_Accord_JoinController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Perfume_Accord_Join

  plug Fumigate.PerfumeList when action in [:new, :create, :edit, :update]
  plug Fumigate.AccordList when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    perfume_accord_joins = Fragrance.list_perfume_accord_joins()
                           |> Fumigate.Repo.preload([:accord, :perfume])
    render(conn, "index.html", perfume_accord_joins: perfume_accord_joins)
  end

  def new(conn, _params) do
    changeset = Fragrance.change_perfume__accord__join(%Perfume_Accord_Join{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"perfume__accord__join" => perfume__accord__join_params}) do
    case Fragrance.create_perfume__accord__join(perfume__accord__join_params) do
      {:ok, perfume__accord__join} ->
        conn
        |> put_flash(:info, "Perfume  accord  join created successfully.")
        |> redirect(to: Routes.perfume__accord__join_path(conn, :show, perfume__accord__join))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    perfume__accord__join = Fragrance.get_perfume__accord__join!(id)
                            |> Fumigate.Repo.preload([:accord, :perfume])
    render(conn, "show.html", perfume__accord__join: perfume__accord__join)
  end

  def edit(conn, %{"id" => id}) do
    perfume__accord__join = Fragrance.get_perfume__accord__join!(id)
    changeset = Fragrance.change_perfume__accord__join(perfume__accord__join)
    render(conn, "edit.html", perfume__accord__join: perfume__accord__join, changeset: changeset)
  end

  def update(conn, %{"id" => id, "perfume__accord__join" => perfume__accord__join_params}) do
    perfume__accord__join = Fragrance.get_perfume__accord__join!(id)

    case Fragrance.update_perfume__accord__join(perfume__accord__join, perfume__accord__join_params) do
      {:ok, perfume__accord__join} ->
        conn
        |> put_flash(:info, "Perfume  accord  join updated successfully.")
        |> redirect(to: Routes.perfume__accord__join_path(conn, :show, perfume__accord__join))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", perfume__accord__join: perfume__accord__join, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    perfume__accord__join = Fragrance.get_perfume__accord__join!(id)
    {:ok, _perfume__accord__join} = Fragrance.delete_perfume__accord__join(perfume__accord__join)

    conn
    |> put_flash(:info, "Perfume  accord  join deleted successfully.")
    |> redirect(to: Routes.perfume__accord__join_path(conn, :index))
  end
end
