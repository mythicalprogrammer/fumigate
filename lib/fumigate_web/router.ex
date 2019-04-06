defmodule FumigateWeb.Router do
  use FumigateWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
    error_handler: FumigateWeb.AuthErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
    error_handler: FumigateWeb.AuthErrorHandler
  end

  pipeline :admin_only do
    plug Fumigate.Plug.EnsureRole, :admin
  end

  scope "/", FumigateWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/advertising", PageController, :advertising
    get "/artificial_intelligence", PageController, :artificial_intelligence
    get "/blog", PageController, :blog
    get "/faq", PageController, :faq
    get "/privacy_policy", PageController, :privacy_policy
    get "/terms_of_service", PageController, :terms_of_service

    resources "/accords", AccordController, only: [:index, :show]
    resources "/notes", NoteController, only: [:index, :show]
    resources "/companies", CompanyController, only: [:index, :show]
    resources "/perfumes", PerfumeController, only: [:index, :show]
  end

  scope "/", FumigateWeb.Pow  do
    pipe_through [:browser, :not_authenticated]
    get "/signup", RegistrationController, :new, as: :signup
    post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", FumigateWeb.Pow do
    pipe_through [:browser, :protected]

    delete "/logout", SessionController, :delete, as: :logout
  end

  scope "/user", FumigateWeb.User, as: :user do
    pipe_through [:browser, :protected]

    get "/perfumes", PerfumeController, :new
    post "/perfumes", PerfumeController, :create
  end

  scope "/admin", FumigateWeb.Admin, as: :admin do
    pipe_through [:browser, :protected, :admin_only]

    resources "/accords", AccordController
    resources "/notes", NoteController
    resources "/companies", CompanyController
    resources "/perfumes", PerfumeController

  end

  #pipeline :api do
  #  plug :accepts, ["json"]
  #end
end
