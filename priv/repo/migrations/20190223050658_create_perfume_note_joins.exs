defmodule Fumigate.Repo.Migrations.CreatePerfumeNoteJoins do
  use Ecto.Migration

  def change do
    create table(:perfume_note_joins) do
      add :note_id, references(:notes, on_delete: :nothing)
      add :perfume_id, references(:perfumes, on_delete: :nothing)

      timestamps()
    end

    create index(:perfume_note_joins, [:note_id])
    create index(:perfume_note_joins, [:perfume_id])
  end
end
