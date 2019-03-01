defmodule FumigateWeb.NoteController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Note

  def index(conn, params) do
    page = Fragrance.list_notes_paginate(params) 
    render(conn, "index.html", page: page) 
  end

  def new(conn, _params) do
    changeset = Fragrance.change_note(%Note{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"note" => note_params}) do
    case Fragrance.create_note(note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: Routes.note_path(conn, :show, note))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Fragrance.get_note!(id)
    render(conn, "show.html", note: note)
  end

  def edit(conn, %{"id" => id}) do
    note = Fragrance.get_note!(id)
    changeset = Fragrance.change_note(note)
    render(conn, "edit.html", note: note, changeset: changeset)
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = Fragrance.get_note!(id)

    case Fragrance.update_note(note, note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note updated successfully.")
        |> redirect(to: Routes.note_path(conn, :show, note))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", note: note, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Fragrance.get_note!(id)
    {:ok, _note} = Fragrance.delete_note(note)

    conn
    |> put_flash(:info, "Note deleted successfully.")
    |> redirect(to: Routes.note_path(conn, :index))
  end
end
