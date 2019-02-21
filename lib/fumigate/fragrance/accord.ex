defmodule Fumigate.Fragrance.Accord do
  use Ecto.Schema
  import Ecto.Changeset


  schema "accords" do
    field :accord_name, :string

    timestamps()
  end

  @doc false
  def changeset(accord, attrs) do
    accord
    |> cast(attrs, [:accord_name])
    |> validate_required([:accord_name])
  end
end
