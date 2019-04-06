defmodule Fumigate.Fragrance.Accord do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "accords" do
    field :accord_name, :string

    timestamps()

    many_to_many :perfumes, Fumigate.Fragrance.Perfume, join_through: Fumigate.Fragrance.Perfume_Accord_Join
    many_to_many :perfume_approvals, Fumigate.Fragrance.PerfumeApproval, 
      join_through: Fumigate.Fragrance.PerfumeApprovalAccordJoin
  end

  @doc false
  def changeset(accord, attrs) do
    accord
    |> cast(attrs, [:accord_name])
    |> validate_required([:accord_name])
  end

  def alphabetical(query) do
    from c in query, order_by: c.accord_name
  end
end
