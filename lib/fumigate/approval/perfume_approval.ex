defmodule Fumigate.Approval.PerfumeApproval do
  use Ecto.Schema
  import Ecto.Changeset

  schema "perfume_approvals" do
    field :concentration, :string
    field :day_released, :integer
    field :gender, GenderEnum 
    field :month_released, MonthEnum
    field :perfume_description, :string
    field :perfume_name, :string
    field :picture_url, :string
    field :year_released, :integer

    many_to_many :companies, Fumigate.Fragrance.Company, 
      join_through: Fumigate.Approval.PerfumeApprovalCompanyJoin

    many_to_many :notes, Fumigate.Fragrance.Note, 
      join_through: Fumigate.Approval.PerfumeApprovalNoteJoin

    many_to_many :accords, Fumigate.Fragrance.Accord, 
      join_through: Fumigate.Approval.PerfumeApprovalAccordJoin

    timestamps()
  end

  @doc false
  def changeset(perfume_approval, attrs) do
    perfume_approval
    |> cast(attrs, [:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released])
    |> validate_required([:perfume_name, :gender, :perfume_description])
  end
end
