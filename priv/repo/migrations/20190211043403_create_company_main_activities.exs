defmodule Fumigate.Repo.Migrations.CreateCompanyMainActivities do
  use Ecto.Migration

  def change do
    create table(:company_main_activities) do
      add :main_activity, :string

      timestamps()
    end
    create unique_index :company_main_activities, :main_activity

  end
end
