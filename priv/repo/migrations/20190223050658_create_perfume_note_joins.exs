defmodule Fumigate.Repo.Migrations.CreatePerfumeNoteJoins do
  use Ecto.Migration

  def change do
    PyramidNoteEnum.create_type
    create table(:perfume_note_joins) do
      add :note_id, references(:notes, on_delete: :nothing), null: false
      add :perfume_id, references(:perfumes, on_delete: :nothing), null: false
      add :pyramid_note, PyramidNoteEnum.type() 

      timestamps()
    end

    create index(:perfume_note_joins, [:note_id])
    create index(:perfume_note_joins, [:perfume_id])
  end

  def down do
    drop table(:perfume_note_joins)
    Ecto.Migration.execute "DROP TYPE pyramid_note"
  end
end