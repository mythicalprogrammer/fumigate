defmodule Fumigate.Fragrance.Perfume do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import Fumigate.Helpers.PerfumeHelper
  import Fumigate.Helpers.ChangesetHelper


  schema "perfumes" do
    field :concentration, :string
    field :day_released, :integer
    field :gender, GenderEnum 
    field :month_released, MonthEnum
    field :perfume_description, :string
    field :perfume_name, :string
    field :picture_url, :string
    field :year_released, :integer

    belongs_to :users, Fumigate.Users.User, foreign_key: :submitter_user_id, references: :id 

    many_to_many :companies, Fumigate.Fragrance.Company, 
      join_through: Fumigate.Fragrance.PerfumeCompanyJoin,
      on_replace: :delete,
      defaults: []

    many_to_many :notes, Fumigate.Fragrance.Note, 
      join_through: Fumigate.Fragrance.PerfumeNoteJoin,
      on_replace: :delete,
      defaults: []

    many_to_many :accords, Fumigate.Fragrance.Accord, 
      join_through: Fumigate.Fragrance.PerfumeAccordJoin,
      on_replace: :delete,
      defaults: []

    has_many :perfume_company_joins, 
      Fumigate.Fragrance.PerfumeCompanyJoin,
      on_replace: :delete,
      defaults: []
    has_many :perfume_accord_joins, 
      Fumigate.Fragrance.PerfumeAccordJoin,
      on_replace: :delete,
      defaults: []
    has_many :perfume_note_joins, 
      Fumigate.Fragrance.PerfumeNoteJoin,
      on_replace: :delete,
      defaults: []

    timestamps()
  end

  @doc false
  def changeset(perfume, attrs) do
    company_records = id_records(:company_id, attrs["company_id"])
    accord_records = id_records(:accord_id, attrs["accord_id"])
    note_records = get_all_note_records(attrs) 

    perfume 
    |> cast(attrs, [:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released, :submitter_user_id])
    |> validate_required([:perfume_name, :gender, :perfume_description, :concentration])
    |> check_companies(company_records)
    |> put_assoc(:perfume_company_joins, company_records)
    |> put_assoc?(:perfume_accord_joins, accord_records)
    |> put_assoc?(:perfume_note_joins, note_records)
  end

  def alphabetical(query) do
    from c in query, order_by: c.perfume_name
  end

  def sort_by_name_preload(query) do
    from c in query, order_by: c.perfume_name, preload: [:companies, :accords, :notes] 
  end

  def get_all_perfumes(query, perfume_ids) do 
    from c in query,
      order_by: c.perfume_name,
      preload: [:accords, :notes],
      where: c.id in ^perfume_ids
  end

  def get_all_perfume_by_name_con_sex(query, name, concentration, gender) do 
    get_all_perf_by_name_con_sex_module_join_table(query, name, concentration, gender, Fumigate.Fragrance.PerfumeCompanyJoin, join_table_perfume())  
  end
end
