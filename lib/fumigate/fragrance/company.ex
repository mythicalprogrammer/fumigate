defmodule Fumigate.Fragrance.Company do
  use Ecto.Schema
  import Ecto.Changeset


  schema "companies" do
    field :company_name, :string, null: false
    field :company_description, :string
    field :company_url, :string
    field :logo_url, :string
    field :day_established, :integer
    field :month_established, MonthEnum
    field :year_established, :integer

    many_to_many :company_types, Fumigate.Fragrance.Company_Type, join_through: Fumigate.Fragrance.Company_Type_Join
    belongs_to :countries, Fumigate.Fragrance.Country, foreign_key: :country_id
    belongs_to :parent_company, Fumigate.Fragrance.Company
    has_many :child_company, Fumigate.Fragrance.Company, foreign_key: :parent_company_id
    belongs_to :company_main_activities, Fumigate.Fragrance.Company_Main_Activity, foreign_key: :company_main_activity_id
    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:company_name, :company_description, :logo_url, :year_established, :month_established, :day_established, :company_url])
    |> validate_required([:company_name, :company_description, :logo_url, :year_established, :month_established, :day_established, :company_url])
  end
end
