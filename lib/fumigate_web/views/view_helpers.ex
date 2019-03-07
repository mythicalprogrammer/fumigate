defmodule FumigateWeb.ViewHelpers do
  @moduledoc """
  For guardian logged in user information.
  """

  def current_user(conn) do
     check = Guardian.Plug.current_resource(conn)
     #IO.inspect(check)
  end

  def logged_in?(conn, _opts) do
    check = Guardian.Plug.authenticated?(conn, []) 
    IO.inspect(check)
  end
end
