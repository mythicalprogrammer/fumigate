defmodule Fumigate.Repo.Migrations.CreatePerfumes do
  use Ecto.Migration

  def change do
    GenderEnum.create_type
    create table(:perfumes) do
      add :perfume_name, :string
      add :concentration, :string
      add :gender, GenderEnum.type() 
      add :perfume_description, :text
      add :picture_url, :string
      add :year_released, :integer
      add :month_released, MonthEnum.type() 
      add :day_released, :integer

      timestamps()
    end

  end

  def down do
    drop table(:perfumes)
    Ecto.Migration.execute "DROP TYPE gender"
    Ecto.Migration.execute "DROP TYPE month"
  end
end
