defmodule FumigateWeb.PageController do
  use FumigateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def about(conn, _params) do
    render(conn, "about.html")
  end

  def advertising(conn, _params) do
    render(conn, "advertising.html")
  end

  def artificial_intelligence(conn, _params) do
    render(conn, "artificial_intelligence.html")
  end
end
