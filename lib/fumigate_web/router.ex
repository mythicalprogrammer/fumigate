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

    resources "/accords", AccordController, only: [:index, :show]
    resources "/notes", NoteController, only: [:index, :show]
    resources "/companies", CompanyController, only: [:index, :show]
    resources "/perfumes", PerfumeController, only: [:index, :show]

    resources "/manage_accords", ManageAccordController
    resources "/manage_notes", ManageNoteController
    resources "/manage_companies", ManageCompanyController
    resources "/manage_perfumes", ManagePerfumeController

    resources "/perfume_company_joins", Perfume_Company_JoinController
    resources "/perfume_note_joins", Perfume_Note_JoinController
    resources "/perfume_accord_joins", Perfume_Accord_JoinController
  end

  #pipeline :api do
  #  plug :accepts, ["json"]
  #end
end
