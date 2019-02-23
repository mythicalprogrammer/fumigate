defmodule Fumigate.Fragrance.Perfume do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "perfumes" do
    field :concentration, :string
    field :day_released, :integer
    field :gender, GenderEnum 
    field :month_released, :integer
    field :perfume_description, :string
    field :perfume_name, :string
    field :picture_url, :string
    field :year_released, :integer

    many_to_many :companies, Fumigate.Fragrance.Company, join_through: Fumigate.Fragrance.Perfume_Company_Join

    many_to_many :notes, Fumigate.Fragrance.Note, join_through: Fumigate.Fragrance.Perfume_Note_Join
    timestamps()
  end

  @doc false
  def changeset(perfume, attrs) do
    perfume
    |> cast(attrs, [:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released])
    |> validate_required([:perfume_name, :gender, :perfume_description])
  end

  def alphabetical(query) do
    from c in query, order_by: c.perfume_name
  end
end
