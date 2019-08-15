defmodule Fumigate.Repo.Migrations.AddForeignKeySubmitterUserIdToPerfumesTable do
  use Ecto.Migration

  def change do
    alter table(:perfumes) do
      add :submitter_user_id, references(:users)
    end
  end
end
