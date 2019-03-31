defmodule FumigateWeb.NavbarView do
  use FumigateWeb, :view

  def login?(%Plug.Conn{assigns: %{current_user: %Fumigate.Users.User{email: email}}}) when is_binary(email), do: true 
  def login?(_), do: false 
end
