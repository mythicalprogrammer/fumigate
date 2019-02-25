defmodule Fumigate.Fragrance.Perfume_Accord_Join do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "perfume_accord_joins" do
    belongs_to :accord, Fumigate.Fragrance.Accord
    belongs_to :perfume, Fumigate.Fragrance.Perfume

    timestamps()
  end

  @doc false
  def changeset(perfume__accord__join, attrs) do
    perfume__accord__join
    |> cast(attrs, [:accord_id, :perfume_id])
    |> validate_required([:accord_id, :perfume_id])
    |> assoc_constraint(:perfume)
    |> assoc_constraint(:accord)
  end

  def get_all_accords_by_perfume_id(query, id) do
    from c in query, 
    select: c.id, 
    where: c.perfume_id == ^id
  end
end
