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
      on_replace: :delete

    many_to_many :notes, Fumigate.Fragrance.Note, 
      join_through: Fumigate.Fragrance.PerfumeNoteJoin,
      on_replace: :delete

    many_to_many :accords, Fumigate.Fragrance.Accord, 
      join_through: Fumigate.Fragrance.PerfumeAccordJoin,
      on_replace: :delete

    has_many :perfume_company_joins, 
      Fumigate.Fragrance.PerfumeCompanyJoin,
      on_replace: :delete
    has_many :perfume_accord_joins, 
      Fumigate.Fragrance.PerfumeAccordJoin,
      on_replace: :delete
    has_many :perfume_note_joins, 
      Fumigate.Fragrance.PerfumeNoteJoin,
      on_replace: :delete

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

  def get_all_perfume_by_perfume_name_con_comp(query, name, concentration, companies) do 
    query = get_all_perfume_by_perfume_name_con(query, name, concentration) 
    query = Enum.reduce(companies, query, 
                        fn(company, query) -> 
                          match_all_company_for_dupe(query, company) 
                        end)
    from q in query,
      group_by: q.id
  end

  defp match_all_company_for_dupe(query, nil) do
    query
  end
  defp match_all_company_for_dupe(query, []) do
    query
  end
  defp match_all_company_for_dupe(query, company) do
    from p in query,
      join: j in Fumigate.Fragrance.PerfumeCompanyJoin, 
      where: p.id == j.perfume_id,
      join: c in Fumigate.Fragrance.Company, 
      where: c.id == j.company_id,
      where: c.company_name in [^company] 
  end

  def get_all_perfume_by_perfume_name_con(query, name, concentration) do 
    from p in query,
      join: j in Fumigate.Fragrance.PerfumeCompanyJoin, where: p.id == j.perfume_id,
      join: c in Fumigate.Fragrance.Company, where: c.id == j.company_id,
      where: [perfume_name: ^name],
      where: [concentration: ^concentration]
  end
end
