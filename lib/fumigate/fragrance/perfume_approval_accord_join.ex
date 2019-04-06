defmodule Fumigate.Fragrance.PerfumeApprovalAccordJoin do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "perfume_approval_accord_joins" do
    belongs_to :accord, Fumigate.Fragrance.Accord
    belongs_to :perfume_approval, Fumigate.Fragrance.PerfumeApproval

    timestamps()
  end

  @doc false
  def changeset(perfume_approval_accord_join, attrs) do
    perfume_approval_accord_join
    |> cast(attrs, [:accord_id, :perfume_approval_id])
    |> validate_required([:accord_id, :perfume_approval_id])
    |> assoc_constraint(:perfume_approval)
    |> assoc_constraint(:accord)
  end

  def get_all_accords_by_perfume_approval_id(query, id) do
    from c in query, 
    where: c.perfume_approval_id == ^id,
    select: c.accord_id 
  end

  def delete_all_accord_joins_by_perfume_approval_id(query, id) do
    from c in query, 
    where: c.perfume_approval_id == ^id
  end
end
