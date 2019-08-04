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
    company_records = id_records(:company_id, attrs["company"])
    accord_records = id_records(:accord_id, attrs["accord_id"])
    note_records = get_all_note_records(attrs) 

    perfume 
    |> cast(attrs, [:perfume_name, :concentration, :gender, :perfume_description, :picture_url, :year_released, :month_released, :day_released])
    |> validate_required([:perfume_name, :gender, :perfume_description])
    |> put_assoc(:perfume_company_joins, company_records)
    |> put_assoc?(:perfume_accord_joins, accord_records)
    |> put_assoc?(:perfume_note_joins, note_records)
  end

  defp put_assoc?(changeset, _atom, nil), do: changeset
  defp put_assoc?(changeset, atom, records) do
    changeset
    |> put_assoc(atom, records)
  end

  defp get_all_note_records(attrs) do
    note_base_records = 
      if attrs["base_note_id"] do
        id_note_records(:note_id, :base, attrs["base_note_id"])
      else
       [] 
      end

    note_middle_records = 
      if attrs["middle_note_id"] do
        id_note_records(:note_id, :middle, attrs["middle_note_id"])
      else
        [] 
      end

    note_top_records = 
      if attrs["top_note_id"] do
        id_note_records(:note_id, :top, attrs["top_note_id"])
      else
        [] 
      end

    note_records = note_base_records ++ note_middle_records ++ note_top_records

    if length(note_records) == 0 do
      nil
    else
      note_records
    end
  end

  defp id_note_records(key, pyramid, ids) do
    if is_nil(ids) do
      ids
    else 
      ids 
      |> Enum.map(
        fn(id) -> %{
          key => String.to_integer(id),
          :pyramid_note => pyramid
        } end)
    end
  end

  defp id_records(key, ids) do
    if is_nil(ids) do
      ids
    else 
      ids 
      |> Enum.map(
        fn(id) -> %{
          key => String.to_integer(id)
        } end)
    end
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
