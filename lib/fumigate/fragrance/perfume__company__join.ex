defmodule Fumigate.Fragrance.Perfume_Company_Join do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "perfume_company_joins" do

    belongs_to :company, Fumigate.Fragrance.Company
    belongs_to :perfume, Fumigate.Fragrance.Perfume
    timestamps()
  end

  @doc false
  def changeset(perfume__company__join, attrs) do
    perfume__company__join
    |> cast(attrs, [:company_id, :perfume_id])
    |> validate_required([:company_id, :perfume_id])
    |> assoc_constraint(:perfume)
    |> assoc_constraint(:company)
  end

  def get_all_companies_by_perfume_id(query, id) do
    from c in query, 
    where: c.perfume_id == ^id,
    select: c.company_id 
  end

  def delete_all_company_joins_by_perfume_id(query, id) do
    from c in query, 
    where: c.perfume_id == ^id
  end
end
