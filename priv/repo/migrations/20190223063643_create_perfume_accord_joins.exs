defmodule Fumigate.Repo.Migrations.CreatePerfumeAccordJoins do
  use Ecto.Migration

  def change do
    create table(:perfume_accord_joins) do
      add :accord_id, references(:accords, on_delete: :nothing)
      add :perfume_id, references(:perfumes, on_delete: :nothing)

      timestamps()
    end

    create index(:perfume_accord_joins, [:accord_id])
    create index(:perfume_accord_joins, [:perfume_id])
  end
end
