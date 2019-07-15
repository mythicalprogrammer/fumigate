defmodule Fumigate.Fragrance.CompanyType do
  use Ecto.Schema
  import Ecto.Changeset


  schema "company_types" do
    field :company_type, :string, null: false

    many_to_many :companies, Fumigate.Fragrance.Company, join_through: Fumigate.Fragrance.CompanyTypeJoin
    timestamps()
  end

  @doc false
  def changeset(company_type, attrs) do
    company_type
    |> cast(attrs, [:company_type])
    |> validate_required([:company_type])
  end
end
