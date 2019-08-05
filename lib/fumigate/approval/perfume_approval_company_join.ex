defmodule Fumigate.Approval.PerfumeApprovalCompanyJoin do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "perfume_approval_company_joins" do

    belongs_to :company, Fumigate.Fragrance.Company, on_replace: :delete
    belongs_to :perfume_approval, Fumigate.Approval.PerfumeApproval, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(perfume_approval_company_join, attrs) do
    perfume_approval_company_join
    |> cast(attrs, [:company_id, :perfume_approval_id])
    |> validate_required([:company_id, :perfume_approval_id])
    |> assoc_constraint(:perfume_approval)
    |> assoc_constraint(:company)
  end

  def get_all_companies_by_perfume_approval_id(query, id) do
    from c in query, 
    where: c.perfume_approval_id == ^id,
    select: c.company_id 
  end

  def delete_all_company_joins_by_approval_perfume_id(query, id) do
    from c in query, 
    where: c.perfume_approval_id == ^id
  end

  def get_perfume_approval_id_by_company_id(query, id) do
    from c in query, 
    where: c.company_id == ^id,
    select: c.perfume_approval_id 
  end

  def get_all_companies_by_perfume_id(query, id) do
    from c in query, 
    where: c.perfume_approval_id == ^id,
    select: c.company_id 
  end

  def delete_all_company_joins_by_perfume_id(query, id) do
    from c in query, 
    where: c.perfume_approval_id == ^id
  end
end
