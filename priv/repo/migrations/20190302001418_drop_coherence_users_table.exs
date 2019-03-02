defmodule Fumigate.Repo.Migrations.DropCoherenceUsersTable do
  use Ecto.Migration

  def change do
    drop table(:users)
  end
end
