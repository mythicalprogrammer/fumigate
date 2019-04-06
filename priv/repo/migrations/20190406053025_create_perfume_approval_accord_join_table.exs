defmodule Fumigate.Repo.Migrations.CreatePerfumeApprovalAccordJoinTable do
  use Ecto.Migration

  def change do
    create table(:perfume_approval_accord_joins) do
      add :perfume_approval_id, references(:perfume_approvals, on_delete: :nothing), null: false
      add :accord_id, references(:accords, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:perfume_approval_accord_joins, [:accord_id])
    create index(:perfume_approval_accord_joins, [:perfume_approval_id])
    create unique_index(:perfume_approval_accord_joins, [:accord_id, :perfume_approval_id])
  end
end
