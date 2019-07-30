defmodule Fumigate.Repo.Migrations.CreatePerfumeApprovalCompanyJoinTable do
  use Ecto.Migration

  def change do
    create table(:perfume_approval_company_joins) do
      add :company_id, references(:companies, on_delete: :delete_all), null: false
      add :perfume_approval_id, references(:perfume_approvals, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:perfume_approval_company_joins, [:company_id])
    create index(:perfume_approval_company_joins, [:perfume_approval_id])
  end
end
