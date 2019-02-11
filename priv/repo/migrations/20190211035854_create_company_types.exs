defmodule Fumigate.Repo.Migrations.CreateCompanyTypes do
  use Ecto.Migration

  def change do
    create table(:company_types) do
      add :company_type, :string, null: false
      timestamps()
    end

    create unique_index :company_types, :company_type
  end
end
