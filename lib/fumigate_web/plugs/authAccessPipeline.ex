defmodule FumigateWeb.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :fumigate

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
end
