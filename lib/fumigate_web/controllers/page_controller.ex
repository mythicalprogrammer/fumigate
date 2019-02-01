defmodule FumigateWeb.PageController do
  use FumigateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
