defmodule Fumigate.Fragrance.Perfume_Note_Join do
  use Ecto.Schema
  import Ecto.Changeset


  schema "perfume_note_joins" do
    field :pyramid_note, PyramidNoteEnum 
    belongs_to :note, Fumigate.Fragrance.Note
    belongs_to :perfume, Fumigate.Fragrance.Perfume

    timestamps()
  end

  @doc false
  def changeset(perfume__note__join, attrs) do
    perfume__note__join
    |> cast(attrs, [:note_id, :perfume_id, :pyramid_note])
    |> validate_required([:note_id, :perfume_id])
    |> assoc_constraint(:perfume)
    |> assoc_constraint(:note)
  end
end
