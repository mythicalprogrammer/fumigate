defmodule FumigateWeb.LoginController do
  use FumigateWeb, :controller

  alias Fumigate.Accounts
  alias Fumigate.Accounts.User

  def new(conn, _params) do
    changeset = Fumigate.Accounts.change_user(%User{})
    render(conn, "index.html", changeset: changeset, action: Routes.login_path(conn, :login))
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    Accounts.get_user_by_email_and_password(email, password)
    |> login_reply(conn)
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Fumigate.Guardian.Plug.sign_in(user, %{}, [ttl: {24, :hour}, permissions: user.permissions])
    |> redirect(to: "/")
  end

  defp login_reply({:error, _reason}, conn) do
    conn
    |> put_flash(:error, "Something went wrong. Either account does not exist or password is wrong.")
    |> new(%{})
  end
end
