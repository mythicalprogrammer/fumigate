defmodule Fumigate.Fragrance.Company_Type do
  use Ecto.Schema
  import Ecto.Changeset


  schema "company_types" do
    field :company_type, :string

    many_to_many :companies, Fumigate.Fragrance.Company, join_through: Fumigate.Fragrance.Company_Type_Join
    timestamps()
  end

  @doc false
  def changeset(company_type, attrs) do
    company_type
    |> cast(attrs, [:company_type])
    |> validate_required([:company_type])
  end
end
