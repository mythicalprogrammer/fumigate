defmodule Fumigate.Fragrance do
  @moduledoc """
  The Fragrance context.
  """

  import Ecto.Query, warn: false
  alias Fumigate.Repo
  alias Fumigate.Fragrance.Country
  alias Fumigate.Fragrance.Company
  alias Fumigate.Fragrance.CompanyType
  alias Fumigate.Fragrance.CompanyMainActivity
  alias Fumigate.Fragrance.Perfume
  alias Fumigate.Fragrance.PerfumeCompanyJoin
  alias Fumigate.Fragrance.Accord
  alias Fumigate.Fragrance.Note
  alias Fumigate.Fragrance.PerfumeNoteJoin
  alias Fumigate.Fragrance.PerfumeAccordJoin
  import Fumigate.Helpers.PerfumeHelper

  def list_notes_paginate(params) do
    Note
    |> Note.alphabetical() 
    |> Repo.paginate(params)
  end 

  def list_accords_paginate(params) do
    Accord 
    |> Accord.alphabetical() 
    |> Repo.paginate(params)
  end 

  def get_perfumes_by_company_id(id) do
    perfume_ids = get_perfume_id_by_company_id(id) 
    Perfume
    |> Perfume.get_all_perfumes(perfume_ids)
    |> Repo.all()
  end

  def get_perfume_id_by_company_id(id) do
    PerfumeCompanyJoin
    |> PerfumeCompanyJoin.get_perfume_id_by_company_id(id)
    |> Repo.all()
  end

  def insert_all_companies(company_id, perfume_id) do
    records = company_id |> Enum.map(fn(x) -> [perfume_id: perfume_id, company_id: String.to_integer(x), inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second), updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)] end)
    PerfumeCompanyJoin
    |> Repo.insert_all(records)
  end

  def delete_all_company_joins_by_perfume_id(id) do
    queryable = PerfumeCompanyJoin |> PerfumeCompanyJoin.delete_all_company_joins_by_perfume_id(id) 
    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:delete_all, queryable)
    |> Repo.transaction()
  end


  def select_all_companies_by_perfume_id(id) do
    PerfumeCompanyJoin
    |> PerfumeCompanyJoin.get_all_companies_by_perfume_id(id) 
    |> Repo.all()
  end

  def get_all_base_notes_by_perfume_id(id) do
      base_note_ids = select_all_base_notes_by_perfume_id(id) 
      Note
      |> Note.get_all_by_id(base_note_ids) 
      |> Repo.all()
  end

  def get_all_middle_notes_by_perfume_id(id) do
      middle_note_ids = select_all_middle_notes_by_perfume_id(id) 
      Note
      |> Note.get_all_by_id(middle_note_ids) 
      |> Repo.all()
  end

  def get_all_top_notes_by_perfume_id(id) do
      top_note_ids = select_all_top_notes_by_perfume_id(id) 
      Note
      |> Note.get_all_by_id(top_note_ids) 
      |> Repo.all()
  end

  def insert_all_notes_by_perfume_id(notes, perfume_id, pyramid_note) do
    records = notes |> Enum.map(fn(x) -> [perfume_id: perfume_id, note_id: String.to_integer(x), pyramid_note: pyramid_note, inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second), updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)] end)
    PerfumeNoteJoin
    |> Repo.insert_all(records)
  end

  def delete_all_note_joins_by_perfume_id(perfume_id, pyramid_note) do
    queryable = PerfumeNoteJoin |> PerfumeNoteJoin.delete_all_note_joins_by_perfume_id(perfume_id, pyramid_note) 
    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:delete_all, queryable)
    |> Repo.transaction()
  end

  def select_all_top_notes_by_perfume_id(id) do
    select_all_notes_by_perfume_id(id, "top") 
  end

  def select_all_middle_notes_by_perfume_id(id) do
    select_all_notes_by_perfume_id(id, "middle") 
  end

  def select_all_base_notes_by_perfume_id(id) do
    select_all_notes_by_perfume_id(id, "base") 
  end

  defp select_all_notes_by_perfume_id(perfume_id, pyramid_note) do
    PerfumeNoteJoin
    |> PerfumeNoteJoin.get_all_notes_by_perfume_id(perfume_id, pyramid_note) 
    |> Repo.all()
  end

  def delete_all_accord_joins_by_perfume_id(perfume_id) do
    queryable = PerfumeAccordJoin |> PerfumeAccordJoin.delete_all_accord_joins_by_perfume_id(perfume_id) 
    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:delete_all, queryable)
    |> Repo.transaction()
  end

  def select_all_accords_by_perfume_id(perfume_id) do
    PerfumeAccordJoin
    |> PerfumeAccordJoin.get_all_accords_by_perfume_id(perfume_id) 
    |> Repo.all()
  end
  
  def insert_all_accords(accords, perfume) do
    records = accords |> Enum.map(fn(x) -> [perfume_id: perfume.id, accord_id: String.to_integer(x), inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second), updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)] end)
    PerfumeAccordJoin
    |> Repo.insert_all(records)
  end

  def list_perfumes_paginate(params) do
    Perfume
    |> Perfume.sort_by_name_preload() 
    |> Repo.paginate(params)
  end 

  def list_companies_paginate(params) do
    Company
    |> Company.sort_by_name_preload() 
    |> Repo.paginate(params)
  end 

  def list_alphabetical_accords do
    Accord
    |> Accord.alphabetical()
    |> Repo.all()
  end

  def list_alphabetical_notes do
    Note
    |> Note.alphabetical()
    |> Repo.all()
  end

  def list_alphabetical_perfumes do
    Perfume
    |> Perfume.alphabetical()
    |> Repo.all()
  end

  def list_alphabetical_companies do
    Company
    |> Company.alphabetical()
    |> Repo.all()
  end

  def list_alphabetical_countries do
    Country
    |> Country.alphabetical()
    |> Repo.all()
  end

  def list_alphabetical_company_main_activities do
    CompanyMainActivity
    |> CompanyMainActivity.alphabetical()
    |> Repo.all()
  end

  def create_company_main_activity(main_activity) do
    Repo.get_by(CompanyMainActivity, main_activity: main_activity) || Repo.insert!(%CompanyMainActivity{main_activity: main_activity})
  end

  def create_company_type(company_type) do
    Repo.get_by(CompanyType, company_type: company_type) || Repo.insert!(%CompanyType{company_type: company_type})
  end

  def create_country(name) do
    Repo.get_by(Country, name: name) || Repo.insert!(%Country{name: name})
  end


  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id), do: Repo.get!(Company, id)

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{source: %Company{}}

  """
  def change_company(%Company{} = company) do
    Company.changeset(company, %{})
  end


  @doc """
  Returns the list of perfumes.

  ## Examples

      iex> list_perfumes()
      [%Perfume{}, ...]

  """
  def list_perfumes do
    Repo.all(Perfume)
  end

  @doc """
  Gets a single perfume.

  Raises `Ecto.NoResultsError` if the Perfume does not exist.

  ## Examples

      iex> get_perfume!(123)
      %Perfume{}

      iex> get_perfume!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perfume!(id), do: Repo.get!(Perfume, id)

  @doc """
  Creates a perfume.

  ## Examples

      iex> create_perfume(%{field: value})
      {:ok, %Perfume{}}

      iex> create_perfume(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perfume(attrs \\ %{}) do
    %Perfume{}
    |> Perfume.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perfume.

  ## Examples

      iex> update_perfume(perfume, %{field: new_value})
      {:ok, %Perfume{}}

      iex> update_perfume(perfume, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perfume(%Perfume{} = perfume, attrs) do
    perfume
    |> Perfume.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Perfume.

  ## Examples

      iex> delete_perfume(perfume)
      {:ok, %Perfume{}}

      iex> delete_perfume(perfume)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perfume(%Perfume{} = perfume) do
    Repo.delete(perfume)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perfume changes.

  ## Examples

      iex> change_perfume(perfume)
      %Ecto.Changeset{source: %Perfume{}}

  """
  def change_perfume(%Perfume{} = perfume) do
    Perfume.changeset(perfume, %{})
  end

  @doc """
  Returns the list of perfume_company_joins.

  ## Examples

      iex> list_perfume_company_joins()
      [%PerfumeCompanyJoin{}, ...]

  """
  def list_perfume_company_joins do
    Repo.all(PerfumeCompanyJoin)
  end

  @doc """
  Gets a single perfume_company_join.

  Raises `Ecto.NoResultsError` if the Perfume  company  join does not exist.

  ## Examples

      iex> get_perfume_company_join!(123)
      %PerfumeCompanyJoin{}

      iex> get_perfume_company_join!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perfume_company_join!(id), do: Repo.get!(PerfumeCompanyJoin, id)

  @doc """
  Creates a perfume_company_join.

  ## Examples

      iex> create_perfume_company_join(%{field: value})
      {:ok, %PerfumeCompanyJoin{}}

      iex> create_perfume_company_join(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perfume_company_join(attrs \\ %{}) do
    %PerfumeCompanyJoin{}
    |> PerfumeCompanyJoin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perfume_company_join.

  ## Examples

      iex> update_perfume_company_join(perfume_company_join, %{field: new_value})
      {:ok, %PerfumeCompanyJoin{}}

      iex> update_perfume_company_join(perfume_company_join, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perfume_company_join(%PerfumeCompanyJoin{} = perfume_company_join, attrs) do
    perfume_company_join
    |> PerfumeCompanyJoin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PerfumeCompanyJoin.

  ## Examples

      iex> delete_perfume_company_join(perfume_company_join)
      {:ok, %PerfumeCompanyJoin{}}

      iex> delete_perfume_company_join(perfume_company_join)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perfume_company_join(%PerfumeCompanyJoin{} = perfume_company_join) do
    Repo.delete(perfume_company_join)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perfume_company_join changes.

  ## Examples

      iex> change_perfume_company_join(perfume_company_join)
      %Ecto.Changeset{source: %PerfumeCompanyJoin{}}

  """
  def change_perfume_company_join(%PerfumeCompanyJoin{} = perfume_company_join) do
    PerfumeCompanyJoin.changeset(perfume_company_join, %{})
  end

  @doc """
  Returns the list of accords.

  ## Examples

      iex> list_accords()
      [%Accord{}, ...]

  """
  def list_accords do
    Repo.all(Accord)
  end

  @doc """
  Gets a single accord.

  Raises `Ecto.NoResultsError` if the Accord does not exist.

  ## Examples

      iex> get_accord!(123)
      %Accord{}

      iex> get_accord!(456)
      ** (Ecto.NoResultsError)

  """
  def get_accord!(id), do: Repo.get!(Accord, id)

  @doc """
  Creates a accord.

  ## Examples

      iex> create_accord(%{field: value})
      {:ok, %Accord{}}

      iex> create_accord(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_accord(attrs \\ %{}) do
    %Accord{}
    |> Accord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a accord.

  ## Examples

      iex> update_accord(accord, %{field: new_value})
      {:ok, %Accord{}}

      iex> update_accord(accord, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_accord(%Accord{} = accord, attrs) do
    accord
    |> Accord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Accord.

  ## Examples

      iex> delete_accord(accord)
      {:ok, %Accord{}}

      iex> delete_accord(accord)
      {:error, %Ecto.Changeset{}}

  """
  def delete_accord(%Accord{} = accord) do
    Repo.delete(accord)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking accord changes.

  ## Examples

      iex> change_accord(accord)
      %Ecto.Changeset{source: %Accord{}}

  """
  def change_accord(%Accord{} = accord) do
    Accord.changeset(accord, %{})
  end

  @doc """
  Returns the list of notes.

  ## Examples

      iex> list_notes()
      [%Note{}, ...]

  """
  def list_notes do
    Repo.all(Note)
  end

  @doc """
  Gets a single note.

  Raises `Ecto.NoResultsError` if the Note does not exist.

  ## Examples

      iex> get_note!(123)
      %Note{}

      iex> get_note!(456)
      ** (Ecto.NoResultsError)

  """
  def get_note!(id), do: Repo.get!(Note, id)

  @doc """
  Creates a note.

  ## Examples

      iex> create_note(%{field: value})
      {:ok, %Note{}}

      iex> create_note(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a note.

  ## Examples

      iex> update_note(note, %{field: new_value})
      {:ok, %Note{}}

      iex> update_note(note, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Note.

  ## Examples

      iex> delete_note(note)
      {:ok, %Note{}}

      iex> delete_note(note)
      {:error, %Ecto.Changeset{}}

  """
  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking note changes.

  ## Examples

      iex> change_note(note)
      %Ecto.Changeset{source: %Note{}}

  """
  def change_note(%Note{} = note) do
    Note.changeset(note, %{})
  end

  @doc """
  Returns the list of perfume_note_joins.

  ## Examples

      iex> list_perfume_note_joins()
      [%PerfumeNoteJoin{}, ...]

  """
  def list_perfume_note_joins do
    Repo.all(PerfumeNoteJoin)
  end

  @doc """
  Gets a single perfume__note__join.

  Raises `Ecto.NoResultsError` if the Perfume  note  join does not exist.

  ## Examples

      iex> get_perfume_note_join!(123)
      %PerfumeNoteJoin{}

      iex> get_perfume_note_join!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perfume_note_join!(id), do: Repo.get!(PerfumeNoteJoin, id)

  @doc """
  Creates a perfume_note_join.

  ## Examples

      iex> create_perfume_note_join(%{field: value})
      {:ok, %PerfumeNoteJoin{}}

      iex> create_perfume_note_join(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perfume_note_join(attrs \\ %{}) do
    %PerfumeNoteJoin{}
    |> PerfumeNoteJoin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perfume_note_join.

  ## Examples

      iex> update_perfume_note_join(perfume_note_join, %{field: new_value})
      {:ok, %PerfumeNoteJoin{}}

      iex> update_perfume_note_join(perfume_note_join, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perfume_note_join(%PerfumeNoteJoin{} = perfume_note_join, attrs) do
    perfume_note_join
    |> PerfumeNoteJoin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Perfume_Note_Join.

  ## Examples

      iex> delete_perfume_note_join(perfume_note_join)
      {:ok, %PerfumeNoteJoin{}}

      iex> delete_perfume_note_join(perfume_note_join)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perfume_note_join(%PerfumeNoteJoin{} = perfume_note_join) do
    Repo.delete(perfume_note_join)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perfume_note_join changes.

  ## Examples

      iex> change_perfume_note_join(perfume_note_join)
      %Ecto.Changeset{source: %PerfumeNoteJoin{}}

  """
  def change_perfume_note_join(%PerfumeNoteJoin{} = perfume_note_join) do
    PerfumeNoteJoin.changeset(perfume_note_join, %{})
  end

  @doc """
  Returns the list of perfume_accord_joins.

  ## Examples

      iex> list_perfume_accord_joins()
      [%PerfumeAccordJoin{}, ...]

  """
  def list_perfume_accord_joins do
    Repo.all(PerfumeAccordJoin)
  end

  @doc """
  Gets a single perfume_accord_join.

  Raises `Ecto.NoResultsError` if the Perfume  accord  join does not exist.

  ## Examples

      iex> get_perfume_accord_join!(123)
      %PerfumeAccordJoin{}

      iex> get_perfume_accord_join!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perfume_accord_join!(id), do: Repo.get!(PerfumeAccordJoin, id)

  @doc """
  Creates a perfume_accord_join.

  ## Examples

      iex> create_perfume_accord_join(%{field: value})
      {:ok, %PerfumeAccordJoin{}}

      iex> create_perfume_accord_join(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perfume_accord_join(attrs \\ %{}) do
    %PerfumeAccordJoin{}
    |> PerfumeAccordJoin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perfume_accord_join.

  ## Examples

      iex> update_perfume_accord_join(perfume_accord_join, %{field: new_value})
      {:ok, %PerfumeAccordJoin{}}

      iex> update_perfume_accord_join(perfume_accord_join, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perfume_accord_join(%PerfumeAccordJoin{} = perfume_accord_join, attrs) do
    perfume_accord_join
    |> PerfumeAccordJoin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Perfume_Accord_Join.

  ## Examples

      iex> delete_perfume_accord_join(perfume_accord_join)
      {:ok, %PerfumeAccordJoin{}}

      iex> delete_perfume_accord_join(perfume_accord_join)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perfume_accord_join(%PerfumeAccordJoin{} = perfume_accord_join) do
    Repo.delete(perfume_accord_join)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perfume_accord_join changes.

  ## Examples

      iex> change_perfume_accord_join(perfume_accord_join)
      %Ecto.Changeset{source: %PerfumeAccordJoin{}}

  """
  def change_perfume_accord_join(%PerfumeAccordJoin{} = perfume_accord_join) do
    PerfumeAccordJoin.changeset(perfume_accord_join, %{})
  end

  def find_perfume_by_name_con_comp_sex(
    name, concentration, companies, gender) do
    if companies == nil do
      false
    else
      results = 
        Perfume
        |> Perfume.get_all_perfume_by_name_con_sex(
          name, concentration, gender) 
        |> Repo.all()

      company_ids = 
        for {company_id, _perfume_id} <- results, do: company_id 

      perfume_ids = 
        for {_company_id, perfume_id} <- results, do: perfume_id 
      perfume_ids = Enum.uniq(perfume_ids)

      companies = format_company(companies)
      {Enum.sort(company_ids) == Enum.sort(companies), perfume_ids}
    end
  end
end
