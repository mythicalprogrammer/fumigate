defmodule Fumigate.Helpers.PerfumeHelper do
  import Ecto.Changeset
  import Ecto.Query


  def check_companies(changeset, nil) do
    add_error(changeset, :company_id, "Company is require.")
  end
  def check_companies(changeset, company_records) do
    if length(company_records) > 0 do
      changeset
    else
      add_error(changeset, :company_id, "Company is require.")
    end
  end

  def get_all_note_records(attrs) do
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

  def id_note_records(key, pyramid, ids) do
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

  def id_records(key, ids) do
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

  def get_all_perfume_by_name_con_sex_module(
    query, name, concentration, gender, module_name) do 
    from p in query,
      join: j in ^module_name, where: p.id == j.perfume_id,
      where: [perfume_name: ^name, 
              concentration: ^concentration,
              gender: ^gender
      ],
      select: j.company_id 
  end
end
