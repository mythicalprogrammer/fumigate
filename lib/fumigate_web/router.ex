defmodule FumigateWeb.Router do
  use FumigateWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
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
    get "/login", LoginController, :new
    post "/login", LoginController, :login

  end

  #pipeline :api do
  #  plug :accepts, ["json"]
  #end
end
