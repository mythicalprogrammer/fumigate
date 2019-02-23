defmodule FumigateWeb.Perfume_Note_JoinController do
  use FumigateWeb, :controller

  plug Fumigate.PerfumeList when action in [:new, :create, :edit, :update]
  plug Fumigate.NoteList when action in [:new, :create, :edit, :update]

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Perfume_Note_Join

  def index(conn, _params) do
    perfume_note_joins = Fragrance.list_perfume_note_joins()
                            |> Fumigate.Repo.preload([:note, :perfume])
    render(conn, "index.html", perfume_note_joins: perfume_note_joins)
  end

  def new(conn, _params) do
    changeset = Fragrance.change_perfume__note__join(%Perfume_Note_Join{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"perfume__note__join" => perfume__note__join_params}) do
    case Fragrance.create_perfume__note__join(perfume__note__join_params) do
      {:ok, perfume__note__join} ->
        conn
        |> put_flash(:info, "Perfume  note  join created successfully.")
        |> redirect(to: Routes.perfume__note__join_path(conn, :show, perfume__note__join))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    perfume__note__join = Fragrance.get_perfume__note__join!(id)
                             |> Fumigate.Repo.preload([:note, :perfume])
    render(conn, "show.html", perfume__note__join: perfume__note__join)
  end

  def edit(conn, %{"id" => id}) do
    perfume__note__join = Fragrance.get_perfume__note__join!(id)
    changeset = Fragrance.change_perfume__note__join(perfume__note__join)
    render(conn, "edit.html", perfume__note__join: perfume__note__join, changeset: changeset)
  end

  def update(conn, %{"id" => id, "perfume__note__join" => perfume__note__join_params}) do
    perfume__note__join = Fragrance.get_perfume__note__join!(id)

    case Fragrance.update_perfume__note__join(perfume__note__join, perfume__note__join_params) do
      {:ok, perfume__note__join} ->
        conn
        |> put_flash(:info, "Perfume  note  join updated successfully.")
        |> redirect(to: Routes.perfume__note__join_path(conn, :show, perfume__note__join))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", perfume__note__join: perfume__note__join, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    perfume__note__join = Fragrance.get_perfume__note__join!(id)
    {:ok, _perfume__note__join} = Fragrance.delete_perfume__note__join(perfume__note__join)

    conn
    |> put_flash(:info, "Perfume  note  join deleted successfully.")
    |> redirect(to: Routes.perfume__note__join_path(conn, :index))
  end
end
