defmodule FumigateWeb.Pow.RegistrationController do
  use FumigateWeb, :controller

  def new(conn, _params) do
    changeset = Pow.Plug.change_user(conn)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Recaptcha.verify(conn.params["g-recaptcha-response"]) do
      {:ok, _response} -> create_user(conn, user_params)

      {:error, _errors} -> 
        changeset = Pow.Plug.change_user(conn)
        conn
        |> put_flash(:error, "There is a problem with Recaptcha.")
        |> render("new.html", changeset: changeset)
    end
  end

  defp create_user(conn, user_params) do
    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
      {:ok, _user, conn} ->
        conn
        |> put_flash(:info, "Welcome!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset, conn} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
