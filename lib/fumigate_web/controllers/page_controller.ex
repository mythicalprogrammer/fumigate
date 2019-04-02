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

  def blog(conn, _params) do
    render(conn, "blog.html")
  end

  def faq(conn, _params) do
    render(conn, "faq.html")
  end

  def privacy_policy(conn, _params) do
    render(conn, "privacy_policy.html")
  end

  def terms_of_service(conn, _params) do
    render(conn, "terms_of_service.html")
  end
end
