defmodule Fumigate.Fragrance.Perfume_Note_Join do
  use Ecto.Schema
  import Ecto.Changeset


  schema "perfume_note_joins" do
    field :note_id, :id
    field :perfume_id, :id
    field :pyramid_note, PyramidNoteEnum 

    timestamps()
  end

  @doc false
  def changeset(perfume__note__join, attrs) do
    perfume__note__join
    |> cast(attrs, [:note_id, :perfume_id])
    |> validate_required([:note_id, :perfume_id])
  end
end
