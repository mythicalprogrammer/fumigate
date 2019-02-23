defmodule Fumigate.Fragrance.Note do
  use Ecto.Schema
  import Ecto.Changeset


  schema "notes" do
    field :note_name, :string

    timestamps()
    many_to_many :perfumes, Fumigate.Fragrance.Perfume, join_through: Fumigate.Fragrance.Perfume_Note_Join
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:note_name])
    |> validate_required([:note_name])
  end
end
