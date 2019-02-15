defmodule Fumigate.Fragrance.Country do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "countries" do
    field :name, :string, null: false

    has_many :companies, Fumigate.Fragrance.Company
    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def alphabetical(query) do
    from c in query, order_by: c.name
  end
end
