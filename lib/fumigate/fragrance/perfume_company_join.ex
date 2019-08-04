defmodule Fumigate.Fragrance.PerfumeCompanyJoin do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "perfume_company_joins" do

    belongs_to :company, Fumigate.Fragrance.Company, on_replace: :delete
    belongs_to :perfume, Fumigate.Fragrance.Perfume, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(perfume_company_join, attrs) do
    perfume_company_join
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

  def get_perfume_id_by_company_id(query, id) do
    from c in query, 
    where: c.company_id == ^id,
    select: c.perfume_id 
  end
end
