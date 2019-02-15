defmodule Fumigate.Fragrance.Perfume do
  use Ecto.Schema
  import Ecto.Changeset


  schema "perfumes" do
    field :concentration, :string
    field :day_released, :integer
    field :gender, :string
    field :month_released, :integer
    field :perfume_description, :string
    field :perfume_name, :string
    field :picture_url, :string
    field :year_released, :integer

    timestamps()
  end

  @doc false
  def changeset(perfume, attrs) do
    perfume
    |> cast(attrs, [:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released])
    |> validate_required([:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released])
  end
end
