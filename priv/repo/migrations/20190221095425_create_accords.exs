defmodule Fumigate.Repo.Migrations.CreateAccords do
  use Ecto.Migration

  def change do
    create table(:accords) do
      add :accord_name, :string

      timestamps()
    end

    create unique_index :accords, :accord_name
  end
end
