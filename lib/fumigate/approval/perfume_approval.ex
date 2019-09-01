defmodule Fumigate.Approval.PerfumeApproval do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import Fumigate.Helpers.PerfumeHelper
  import Fumigate.Helpers.ChangesetHelper

  schema "perfume_approvals" do
    field :concentration, :string
    field :day_released, :integer
    field :gender, GenderEnum 
    field :month_released, MonthEnum
    field :perfume_description, :string
    field :perfume_name, :string
    field :picture_url, :string
    field :year_released, :integer
    field :approved, :boolean, default: false
    
    belongs_to :users, Fumigate.Users.User, foreign_key: :submitter_user_id, references: :id 

    many_to_many :companies, Fumigate.Fragrance.Company, 
      join_through: Fumigate.Approval.PerfumeApprovalCompanyJoin, 
      on_replace: :delete,
      defaults: []

    many_to_many :notes, Fumigate.Fragrance.Note, 
      join_through: Fumigate.Approval.PerfumeApprovalNoteJoin,
      on_replace: :delete,
      defaults: []

    many_to_many :accords, Fumigate.Fragrance.Accord, 
      join_through: Fumigate.Approval.PerfumeApprovalAccordJoin,
      on_replace: :delete,
      defaults: []

    has_many :perfume_approval_company_joins, 
      Fumigate.Approval.PerfumeApprovalCompanyJoin,
      on_replace: :delete,
      defaults: []
    has_many :perfume_approval_accord_joins, 
      Fumigate.Approval.PerfumeApprovalAccordJoin,
      on_replace: :delete,
      defaults: []
    has_many :perfume_approval_note_joins, 
      Fumigate.Approval.PerfumeApprovalNoteJoin,
      on_replace: :delete,
      defaults: []

    timestamps()
  end

  @doc false
  def changeset(perfume_approval, attrs) do
    company_records = id_records(:company_id, attrs["company_id"])
    accord_records = id_records(:accord_id, attrs["accord_id"])
    note_records = get_all_note_records(attrs) 

    perfume_approval
    |> cast(attrs, [:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released, :submitter_user_id, :approved])
    |> validate_required([:perfume_name, :gender, :concentration, :perfume_description, :submitter_user_id])
    |> check_companies(company_records)
    |> put_assoc(:perfume_approval_company_joins, company_records)
    |> put_assoc?(:perfume_approval_accord_joins, accord_records)
    |> put_assoc?(:perfume_approval_note_joins, note_records)
  end

  def changeset_no_assoc(perfume_approval, attrs) do
    perfume_approval
    |> cast(attrs, [:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released, :submitter_user_id, :approved])
    |> validate_required([:perfume_name, :gender, :perfume_description, :submitter_user_id])
  end

  def get_all_perfume_approvals_preload(query) do 
    from c in query, 
      preload: [:accords, :notes, :companies]
  end

  def get_all_perfume_approvals_approved_false_preload(query) do 
    from c in query, 
      where: c.approved == false,
      preload: [:accords, :notes, :companies]
  end

  def get_all_perfume_approval_by_name_con_sex(query, name, concentration, gender) do 
    get_all_perf_by_name_con_sex_module_join_table(query, name, concentration, gender, Fumigate.Approval.PerfumeApprovalCompanyJoin, join_table_perfume_approval())
  end
end
