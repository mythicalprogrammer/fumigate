defmodule Fumigate.Repo.Migrations.CreatePerfumeApprovalsTable do
  use Ecto.Migration

  def change do
    create table(:perfume_approvals) do
      add :perfume_name, :string, null: false
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
    drop table(:perfume_approvals)
  end
end
