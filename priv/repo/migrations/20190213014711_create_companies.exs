defmodule Fumigate.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    MonthEnum.create_type
    create table(:companies) do
      add :company_name, :string
      add :company_description, :text
      add :logo_url, :string
      add :year_established, :integer
      add :month_established, MonthEnum.type() 
      add :day_established, :integer
      add :company_url, :string
      add :country_id, references(:countries, on_delete: :nothing)
      add :parent_company_id, references(:companies, on_delete: :nothing)
      add :company_type_id, references(:company_types, on_delete: :nothing)
      add :company_main_activity_id, references(:company_main_activities, on_delete: :nothing)

      timestamps()
    end

    create index(:companies, [:country_id])
    create index(:companies, [:parent_company_id])
    create index(:companies, [:company_type_id])
    create index(:companies, [:company_main_activity_id])
  end
end
