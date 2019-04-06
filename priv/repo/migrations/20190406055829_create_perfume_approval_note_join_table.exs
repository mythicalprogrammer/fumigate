defmodule Fumigate.Repo.Migrations.CreatePerfumeApprovalNoteJoinTable do
  use Ecto.Migration

  def change do
    create table(:perfume_approval_note_joins) do
      add :note_id, references(:notes, on_delete: :nothing), null: false
      add :perfume_approval_id, references(:perfume_approvals, on_delete: :nothing), null: false
      add :pyramid_note, PyramidNoteEnum.type() 

      timestamps()
    end

    create index(:perfume_approval_note_joins, [:note_id])
    create index(:perfume_approval_note_joins, [:perfume_approval_id])
    create unique_index(:perfume_approval_note_joins, [:note_id, :perfume_approval_id, :pyramid_note])
  end

  def down do
    drop table(:perfume_approval_note_joins)
  end
end
