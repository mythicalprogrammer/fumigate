defmodule Fumigate.Fragrance.Perfume_Note_Join do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


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

  def get_all_notes_by_perfume_id(query, id, pyramid_note) do
    from c in query, 
    where: c.perfume_id == ^id and c.pyramid_note == ^pyramid_note,
    select: c.note_id 
  end

  def delete_all_note_joins_by_perfume_id(query, id, pyramid_note) do
    from c in query, 
    where: c.perfume_id == ^id and c.pyramid_note == ^pyramid_note
  end
end
