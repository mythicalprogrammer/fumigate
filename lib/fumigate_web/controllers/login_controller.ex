defmodule FumigateWeb.LoginController do
  use FumigateWeb, :controller

  alias Fumigate.Account
  alias Fumigate.Account.User

  def index(conn, params) do
    render(conn, "index.html")
  end
end
