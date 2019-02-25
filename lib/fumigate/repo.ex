defmodule Fumigate.Repo do
  use Ecto.Repo,
    otp_app: :fumigate,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 10
end
