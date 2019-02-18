defmodule Fumigate.Fragrance.Perfume_Company_Join do
  use Ecto.Schema
  import Ecto.Changeset


  schema "perfume_company_joins" do
    field :company_id, :id
    field :perfume_id, :id

    timestamps()
  end

  @doc false
  def changeset(perfume__company__join, attrs) do
    perfume__company__join
    |> cast(attrs, [])
    |> validate_required([])
  end
end
