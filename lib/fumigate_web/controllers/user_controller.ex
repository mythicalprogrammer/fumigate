defmodule FumigateWeb.UserController do
  use FumigateWeb, :controller
  
  alias Fumigate.Coherence.Schemas

  def index(conn, _params) do
    users = Schemas.list_user()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Schemas.get_user(id)
    render(conn, "show.html", user: user)
  end
end
