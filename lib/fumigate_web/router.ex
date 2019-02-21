defmodule FumigateWeb.Router do
  use FumigateWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session  
  end


  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end


  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", FumigateWeb do
    pipe_through :protected 
    resources "/testlogin", TestController
  end

  scope "/", FumigateWeb do
    pipe_through :browser
    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show]
    resources "/companies", CompanyController
    resources "/perfumes", PerfumeController
    resources "/perfume_company_joins", Perfume_Company_JoinController
    resources "/accords", AccordController
    resources "/notes", NoteController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FumigateWeb do
  #   pipe_through :api
  # end
end
