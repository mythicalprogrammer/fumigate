defmodule FumigateWeb.Router do
  use FumigateWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug FumigateWeb.AuthAccessPipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FumigateWeb do
    pipe_through :browser
    get "/", PageController, :index
    resources "/companies", CompanyController
    resources "/perfumes", PerfumeController
    resources "/perfume_company_joins", Perfume_Company_JoinController
    resources "/perfume_note_joins", Perfume_Note_JoinController
    resources "/perfume_accord_joins", Perfume_Accord_JoinController
    resources "/accords", AccordController
    resources "/notes", NoteController
    get "/login", LoginController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", FumigateWeb do
    pipe_through :api

    scope "/auth" do
      post "/identity/callback", AuthenticationController, :identity_callback
    end

    pipe_through :authenticated

    resources "/users", UserController, except: [:new, :edit]
  end
end
