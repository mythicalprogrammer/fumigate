defmodule FumigateWeb.Admin.AdminToolsController do
  use FumigateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html") 
  end
end
