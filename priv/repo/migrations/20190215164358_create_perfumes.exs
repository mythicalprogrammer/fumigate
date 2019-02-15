defmodule Fumigate.Repo.Migrations.CreatePerfumes do
  use Ecto.Migration

  def change do
    create table(:perfumes) do
      add :perfume_name, :string
      add :concentration, :string
      add :gender, :string
      add :perfume_description, :string
      add :picture_url, :string
      add :year_released, :integer
      add :month_released, :integer
      add :day_released, :integer

      timestamps()
    end

  end
end
