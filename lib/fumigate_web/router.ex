defmodule FumigateWeb.Router do
  use FumigateWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", FumigateWeb do
    pipe_through :browser
    get "/", PageController, :index

    resources "/accords", AccordController, only: [:index, :show]
    resources "/notes", NoteController, only: [:index, :show]
    resources "/companies", CompanyController, only: [:index, :show]
    resources "/perfumes", PerfumeController, only: [:index, :show]


    resources "/perfume_company_joins", Perfume_Company_JoinController
    resources "/perfume_note_joins", Perfume_Note_JoinController
    resources "/perfume_accord_joins", Perfume_Accord_JoinController
  end

  scope "/admin",FumigateWeb do
    pipe_through [:browser, :protected]

    resources "/manage_accords", ManageAccordController
    resources "/manage_notes", ManageNoteController
    resources "/manage_companies", ManageCompanyController
    resources "/manage_perfumes", ManagePerfumeController

  end

  #pipeline :api do
  #  plug :accepts, ["json"]
  #end
end
