defmodule Fumigate.Fragrance.Company do
  use Ecto.Schema
  import Ecto.Changeset


  schema "companies" do
    field :company_description, :string
    field :company_name, :string
    field :company_url, :string
    field :day_established, :integer
    field :logo_url, :string
    field :month_established, :integer
    field :year_established, :integer
    field :country_id, :id
    field :parent_company_id, :id
    field :company_type_id, :id
    field :company_main_activity_id, :id

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:company_name, :company_description, :logo_url, :year_established, :month_established, :day_established, :company_url])
    |> validate_required([:company_name, :company_description, :logo_url, :year_established, :month_established, :day_established, :company_url])
  end
end
