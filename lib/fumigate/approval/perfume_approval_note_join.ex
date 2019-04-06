defmodule Fumigate.Approval.PerfumeApprovalNoteJoin do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "perfume_approval_note_joins" do
    field :pyramid_note, PyramidNoteEnum 
    belongs_to :note, Fumigate.Fragrance.Note
    belongs_to :perfume_approval, Fumigate.Approval.PerfumeApproval

    timestamps()
  end

  @doc false
  def changeset(perfume_approval_note_join, attrs) do
    perfume_approval_note_join
    |> cast(attrs, [:note_id, :perfume_approval_id, :pyramid_note])
    |> validate_required([:note_id, :perfume_approval_id])
    |> assoc_constraint(:perfume_approval)
    |> assoc_constraint(:note)
  end

  def get_all_notes_by_perfume_approval_id(query, id, pyramid_note) do
    from c in query, 
    where: c.perfume_approval_id == ^id and c.pyramid_note == ^pyramid_note,
    select: c.note_id 
  end

  def delete_all_note_joins_by_perfume_approval_id(query, id, pyramid_note) do
    from c in query, 
    where: c.perfume_approval_id == ^id and c.pyramid_note == ^pyramid_note
  end
end
