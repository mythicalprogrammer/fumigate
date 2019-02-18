defmodule FumigateWeb.Perfume_Company_JoinController do
  use FumigateWeb, :controller

  alias Fumigate.Fragrance
  alias Fumigate.Fragrance.Perfume_Company_Join

  plug :load_companies when action in [:new, :create, :edit, :update]
  plug :load_perfumes when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    perfume_company_joins = Fragrance.list_perfume_company_joins()
                            |> Fumigate.Repo.preload([:company, :perfume])
    render(conn, "index.html", perfume_company_joins: perfume_company_joins)
  end

  def new(conn, _params) do
    changeset = Fragrance.change_perfume__company__join(%Perfume_Company_Join{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"perfume__company__join" => perfume__company__join_params}) do
    case Fragrance.create_perfume__company__join(perfume__company__join_params) do
      {:ok, perfume__company__join} ->
        conn
        |> put_flash(:info, "Perfume  company  join created successfully.")
        |> redirect(to: Routes.perfume__company__join_path(conn, :show, perfume__company__join))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    perfume__company__join = Fragrance.get_perfume__company__join!(id)
                             |> Fumigate.Repo.preload([:company, :perfume])
    render(conn, "show.html", perfume__company__join: perfume__company__join)
  end

  def edit(conn, %{"id" => id}) do
    perfume__company__join = Fragrance.get_perfume__company__join!(id)
    changeset = Fragrance.change_perfume__company__join(perfume__company__join)
    render(conn, "edit.html", perfume__company__join: perfume__company__join, changeset: changeset)
  end

  def update(conn, %{"id" => id, "perfume__company__join" => perfume__company__join_params}) do
    perfume__company__join = Fragrance.get_perfume__company__join!(id)

    case Fragrance.update_perfume__company__join(perfume__company__join, perfume__company__join_params) do
      {:ok, perfume__company__join} ->
        conn
        |> put_flash(:info, "Perfume  company  join updated successfully.")
        |> redirect(to: Routes.perfume__company__join_path(conn, :show, perfume__company__join))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", perfume__company__join: perfume__company__join, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    perfume__company__join = Fragrance.get_perfume__company__join!(id)
    {:ok, _perfume__company__join} = Fragrance.delete_perfume__company__join(perfume__company__join)

    conn
    |> put_flash(:info, "Perfume  company  join deleted successfully.")
    |> redirect(to: Routes.perfume__company__join_path(conn, :index))
  end

  defp load_companies(conn, _) do
    assign(conn, :companies, Fragrance.list_alphabetical_companies())
  end

  defp load_perfumes(conn, _) do
    assign(conn, :perfumes, Fragrance.list_alphabetical_perfumes())
  end
end
