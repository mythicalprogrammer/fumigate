defmodule FumigateWeb.ViewHelpers do
  @moduledoc """
  """

  def username(%Plug.Conn{assigns: %{current_user: %Fumigate.Users.User{username: username}}}), do: to_string(username)
  def username(_), do: ""

  def role(%Plug.Conn{assigns: %{current_user: %Fumigate.Users.User{role: role}}}), do: to_string(role)
  def role(_), do: "" 

  def login?(%Plug.Conn{assigns: %{current_user: %Fumigate.Users.User{email: email}}}) when is_binary(email), do: true 
  def login?(_), do: false 

  def country_name(%{country: %{name: name}}), do: name
  def country_name(_), do: "Unknown" 

  def main_activity(%{company_main_activity: %{main_activity: main_activity}}), do: main_activity 
  def main_activity(_), do: "Unknown" 
end
