defmodule Fumigate.Repo.Migrations.AddRoleColUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
        add :role, :string, null: false
        add :username, :string, null: false
    end
    create unique_index(:users, [:username])
  end
end
