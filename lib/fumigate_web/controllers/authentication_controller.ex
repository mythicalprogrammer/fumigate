defmodule FumigateWeb.AuthenticationController do
  use FumigateWeb, :controller

  alias Fumigate.Accounts
  plug Ueberauth

  def identity_callback(%Plug.Conn{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    email = auth.uid
    password = auth.credentials.other.password
    user = Accounts.get_user_by_email_and_password(email, password)
    handle_user_conn(user, conn)
  end

  defp handle_user_conn(user, conn) do
	case user do
	  {:ok, user} ->
        Fumigate.Guardian.encode_and_sign(user, %{})
        {:ok, jwt, _full_claims} =
          Fumigate.Guardian.encode_and_sign(user, %{})

        conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> json(%{data: %{token: jwt}})

	  # Handle our own error to keep it generic
	  {:error, _reason} ->
		conn
		|> put_status(401)
		|> json(%{message: "user not found"})
	end
  end
end

