defmodule Fumigate.Fragrance do
  @moduledoc """
  The Fragrance context.
  """

  import Ecto.Query, warn: false
  alias Fumigate.Repo
  alias Fumigate.Fragrance.Country

  def create_country(name) do
    Repo.get_by(Country, name: name) || Repo.insert!(%Country{name: name})
  end
end
