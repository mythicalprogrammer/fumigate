defmodule Fumigate.Fragrance.CompanyTypeJoin do
  use Ecto.Schema
  import Ecto.Changeset


  schema "company_type_joins" do

    belongs_to :companies, Fumigate.Fragrance.Company
    belongs_to :company_types, Fumigate.Fragrance.CompanyType
    timestamps()
  end

  @doc false
  def changeset(company_type_join, attrs) do
    company_type_join
    |> cast(attrs, [])
    |> validate_required([])
  end
end
