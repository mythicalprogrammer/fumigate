defmodule FumigateWeb.UserController do
  use FumigateWeb, :controller

  alias Fumigate.Accounts
  alias Fumigate.Accounts.User

  plug Guardian.Permissions.Bitwise, ensure: %{default: [:read_users]}
  plug Guardian.Permissions.Bitwise, [ensure: %{default: [:write_users]}] when action in [:create, :update, :delete]

  action_fallback FumigateWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  #def edit(conn, _params) do
  #  IO.inspect("hello from edit")
  #end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
