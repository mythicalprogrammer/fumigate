defmodule Fumigate.Repo.Migrations.CreateCompanyTypeJoins do
  use Ecto.Migration

  def change do
    create table(:company_type_joins) do
      add :company_id, references(:companies, on_delete: :delete_all), null: false
      add :company_type_id, references(:company_types, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:company_type_joins, [:company_id])
    create index(:company_type_joins, [:company_type_id])
  end
end
