# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fumigate,
  ecto_repos: [Fumigate.Repo]

# Configures the endpoint
config :fumigate, FumigateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OTZjYpX0GIVGuiofbe4ZxII+UIA9jeEK1Sazo0LVT3d0Ojza3ZqMs/Wpbo/oxujN",
  render_errors: [view: FumigateWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Fumigate.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :scrivener_html,
  routes_helper: Fumigate.Router.Helpers,
  view_style: :bootstrap_v4 

config :fumigate, :pow,
  user: Fumigate.Users.User,
  repo: Fumigate.Repo,
  extensions: [PowPersistentSession],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  web_module: FumigateWeb

config :recaptcha,
  public_key: "6Lf3NbwSAAAAAPtqBA2k8dxCQTT7uTzdfslg2zBN",
  secret: "6Lf3NbwSAAAAACqBfPhWP9mCAKgBUsp4yggDqVYd"
