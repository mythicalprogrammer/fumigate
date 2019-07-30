defmodule Fumigate.Repo.Migrations.CreatePerfumeCompanyJoins do
  use Ecto.Migration

  def change do
    create table(:perfume_company_joins) do
      add :company_id, references(:companies, on_delete: :delete_all), null: false
      add :perfume_id, references(:perfumes, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:perfume_company_joins, [:company_id])
    create index(:perfume_company_joins, [:perfume_id])
  end
end
