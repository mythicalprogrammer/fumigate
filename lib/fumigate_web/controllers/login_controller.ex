defmodule FumigateWeb.LoginController do
  use FumigateWeb, :controller

  alias Fumigate.Accounts
  alias Fumigate.Accounts.User

  def new(conn, _params) do
    changeset = Fumigate.Accounts.change_user(%User{})
    render(conn, "index.html", changeset: changeset, action: Routes.login_path(conn, :login))
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password, "remember_me" => remember_me}}) do
    Accounts.get_user_by_email_and_password(email, password)
    |> login_reply(conn, remember_me)
  end

  defp login_reply({:ok, user}, conn, remember_me) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Fumigate.Guardian.Plug.sign_in(user, %{}, [ttl: {24, :hour}, permissions: user.permissions])
    |> remember_me(user, remember_me)
    |> redirect(to: "/")
  end

  defp login_reply({:error, _reason}, conn, _remember_me) do
    conn
    |> put_flash(:error, "Something went wrong. Either account does not exist or password is wrong.")
    |> new(%{})
  end

  defp remember_me(conn, user, remember_me) do
    case remember_me do
      "true" -> 
        Fumigate.Guardian.Plug.remember_me(conn, user)
      "false" ->
        conn
    end
  end
end
