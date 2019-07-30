defmodule Fumigate.Repo.Migrations.CreatePerfumeAccordJoins do
  use Ecto.Migration

  def change do
    create table(:perfume_accord_joins) do
      add :accord_id, references(:accords, on_delete: :delete_all), null: false
      add :perfume_id, references(:perfumes, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:perfume_accord_joins, [:accord_id])
    create index(:perfume_accord_joins, [:perfume_id])
    create unique_index(:perfume_accord_joins, [:accord_id, :perfume_id])
  end
end
