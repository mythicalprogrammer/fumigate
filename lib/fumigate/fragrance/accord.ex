defmodule Fumigate.Fragrance.Accord do
  use Ecto.Schema
  import Ecto.Changeset


  schema "accords" do
    field :accord_name, :string

    timestamps()

    many_to_many :perfumes, Fumigate.Fragrance.Perfume, join_through: Fumigate.Fragrance.Perfume_Accord_Join
  end

  @doc false
  def changeset(accord, attrs) do
    accord
    |> cast(attrs, [:accord_name])
    |> validate_required([:accord_name])
  end
end
