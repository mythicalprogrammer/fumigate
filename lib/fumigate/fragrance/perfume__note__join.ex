defmodule Fumigate.Fragrance.Perfume_Note_Join do
  use Ecto.Schema
  import Ecto.Changeset


  schema "perfume_note_joins" do
    field :note_id, :id
    field :perfume_id, :id

    timestamps()
  end

  @doc false
  def changeset(perfume__note__join, attrs) do
    perfume__note__join
    |> cast(attrs, [])
    |> validate_required([])
  end
end
