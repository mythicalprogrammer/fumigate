defmodule Fumigate.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :note_name, :string, null: false

      timestamps()
    end

    create unique_index :notes, :note_name
  end
end
