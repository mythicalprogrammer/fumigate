defmodule Fumigate.Fragrance.Perfume do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "perfumes" do
    field :concentration, :string
    field :day_released, :integer
    field :gender, GenderEnum 
    field :month_released, MonthEnum
    field :perfume_description, :string
    field :perfume_name, :string
    field :picture_url, :string
    field :year_released, :integer

    many_to_many :companies, Fumigate.Fragrance.Company, join_through: Fumigate.Fragrance.PerfumeCompanyJoin

    many_to_many :notes, Fumigate.Fragrance.Note, join_through: Fumigate.Fragrance.PerfumeNoteJoin

    many_to_many :accords, Fumigate.Fragrance.Accord, join_through: Fumigate.Fragrance.PerfumeAccordJoin

    timestamps()
  end

  @doc false
  def changeset(perfume, attrs) do
    perfume
    |> cast(attrs, [:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released])
    |> validate_required([:perfume_name, :gender, :perfume_description])
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
    from p in query,
      join: j in Fumigate.Fragrance.PerfumeCompanyJoin, where: p.id == j.perfume_id,
      join: c in Fumigate.Fragrance.Company, where: c.id == j.company_id,
      where: [perfume_name: ^name],
      where: [concentration: ^concentration],
      where: c.company_name in ^companies
  end
end
