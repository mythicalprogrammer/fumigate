defmodule Fumigate.Fragrance.Perfume_Company_Join do
  use Ecto.Schema
  import Ecto.Changeset


  schema "perfume_company_joins" do

    belongs_to :company, Fumigate.Fragrance.Company
    belongs_to :perfume, Fumigate.Fragrance.Company
    timestamps()
  end

  @doc false
  def changeset(perfume__company__join, attrs) do
    perfume__company__join
    |> cast(attrs, [:company_id, :perfume_id])
    |> validate_required([:company_id, :perfume_id])
    |> assoc_constraint(:company)
  end
end
