defmodule FumigateWeb.Pow.SessionController do
  use FumigateWeb, :controller

  def new(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Recaptcha.verify(conn.params["g-recaptcha-response"]) do
      {:ok, _response} -> create_session(conn, user_params)

      {:error, _errors} -> 
        changeset = Pow.Plug.change_user(conn, conn.params["user"])

        conn
        |> put_flash(:error, "There is a problem with Recaptcha.")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    {:ok, conn} = Pow.Plug.clear_authenticated_user(conn)
    redirect(conn, to: Routes.page_path(conn, :index))
  end

  defp create_session(conn, user_params) do
    conn
    |> Pow.Plug.authenticate_user(user_params)
    |> case do
      {:ok, conn} ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, conn} ->
        changeset = Pow.Plug.change_user(conn, conn.params["user"])

        conn
        |> put_flash(:error, "Invalid email or password")
        |> render("new.html", changeset: changeset)
    end
  end
end
