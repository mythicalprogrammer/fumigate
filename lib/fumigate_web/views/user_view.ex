defmodule FumigateWeb.UserView do
  use FumigateWeb, :view
  alias Fumigate.Coherence.User

  def first_name(%User{name: name}) do
          name
          |> String.split(" ")
          |> Enum.at(0)
    end
end
