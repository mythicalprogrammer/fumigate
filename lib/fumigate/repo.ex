defmodule Fumigate.Repo do
  use Ecto.Repo,
    otp_app: :fumigate,
    adapter: Ecto.Adapters.Postgres
end
