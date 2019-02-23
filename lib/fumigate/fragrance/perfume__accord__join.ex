defmodule Fumigate.Fragrance.Perfume_Accord_Join do
  use Ecto.Schema
  import Ecto.Changeset


  schema "perfume_accord_joins" do
    field :accord_id, :id
    field :perfume_id, :id

    timestamps()
  end

  @doc false
  def changeset(perfume__accord__join, attrs) do
    perfume__accord__join
    |> cast(attrs, [])
    |> validate_required([])
  end
end
