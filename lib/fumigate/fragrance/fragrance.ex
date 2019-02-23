defmodule Fumigate.Fragrance do
  @moduledoc """
  The Fragrance context.
  """

  import Ecto.Query, warn: false
  alias Fumigate.Repo
  alias Fumigate.Fragrance.Country
  alias Fumigate.Fragrance.Company
  alias Fumigate.Fragrance.Company_Type
  alias Fumigate.Fragrance.Company_Main_Activity
  alias Fumigate.Fragrance.Perfume
  alias Fumigate.Fragrance.Perfume_Company_Join
  alias Fumigate.Fragrance.Accord
  alias Fumigate.Fragrance.Note
  alias Fumigate.Fragrance.Perfume_Note_Join
  alias Fumigate.Fragrance.Perfume_Accord_Join

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
    Company_Main_Activity
    |> Company_Main_Activity.alphabetical()
    |> Repo.all()
  end

  def create_company_main_activity(main_activity) do
    Repo.get_by(Company_Main_Activity, main_activity: main_activity) || Repo.insert!(%Company_Main_Activity{main_activity: main_activity})
  end

  def create_company_type(company_type) do
    Repo.get_by(Company_Type, company_type: company_type) || Repo.insert!(%Company_Type{company_type: company_type})
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
      [%Perfume_Company_Join{}, ...]

  """
  def list_perfume_company_joins do
    Repo.all(Perfume_Company_Join)
  end

  @doc """
  Gets a single perfume__company__join.

  Raises `Ecto.NoResultsError` if the Perfume  company  join does not exist.

  ## Examples

      iex> get_perfume__company__join!(123)
      %Perfume_Company_Join{}

      iex> get_perfume__company__join!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perfume__company__join!(id), do: Repo.get!(Perfume_Company_Join, id)

  @doc """
  Creates a perfume__company__join.

  ## Examples

      iex> create_perfume__company__join(%{field: value})
      {:ok, %Perfume_Company_Join{}}

      iex> create_perfume__company__join(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perfume__company__join(attrs \\ %{}) do
    %Perfume_Company_Join{}
    |> Perfume_Company_Join.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perfume__company__join.

  ## Examples

      iex> update_perfume__company__join(perfume__company__join, %{field: new_value})
      {:ok, %Perfume_Company_Join{}}

      iex> update_perfume__company__join(perfume__company__join, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perfume__company__join(%Perfume_Company_Join{} = perfume__company__join, attrs) do
    perfume__company__join
    |> Perfume_Company_Join.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Perfume_Company_Join.

  ## Examples

      iex> delete_perfume__company__join(perfume__company__join)
      {:ok, %Perfume_Company_Join{}}

      iex> delete_perfume__company__join(perfume__company__join)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perfume__company__join(%Perfume_Company_Join{} = perfume__company__join) do
    Repo.delete(perfume__company__join)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perfume__company__join changes.

  ## Examples

      iex> change_perfume__company__join(perfume__company__join)
      %Ecto.Changeset{source: %Perfume_Company_Join{}}

  """
  def change_perfume__company__join(%Perfume_Company_Join{} = perfume__company__join) do
    Perfume_Company_Join.changeset(perfume__company__join, %{})
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
      [%Perfume_Note_Join{}, ...]

  """
  def list_perfume_note_joins do
    Repo.all(Perfume_Note_Join)
  end

  @doc """
  Gets a single perfume__note__join.

  Raises `Ecto.NoResultsError` if the Perfume  note  join does not exist.

  ## Examples

      iex> get_perfume__note__join!(123)
      %Perfume_Note_Join{}

      iex> get_perfume__note__join!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perfume__note__join!(id), do: Repo.get!(Perfume_Note_Join, id)

  @doc """
  Creates a perfume__note__join.

  ## Examples

      iex> create_perfume__note__join(%{field: value})
      {:ok, %Perfume_Note_Join{}}

      iex> create_perfume__note__join(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perfume__note__join(attrs \\ %{}) do
    %Perfume_Note_Join{}
    |> Perfume_Note_Join.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perfume__note__join.

  ## Examples

      iex> update_perfume__note__join(perfume__note__join, %{field: new_value})
      {:ok, %Perfume_Note_Join{}}

      iex> update_perfume__note__join(perfume__note__join, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perfume__note__join(%Perfume_Note_Join{} = perfume__note__join, attrs) do
    perfume__note__join
    |> Perfume_Note_Join.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Perfume_Note_Join.

  ## Examples

      iex> delete_perfume__note__join(perfume__note__join)
      {:ok, %Perfume_Note_Join{}}

      iex> delete_perfume__note__join(perfume__note__join)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perfume__note__join(%Perfume_Note_Join{} = perfume__note__join) do
    Repo.delete(perfume__note__join)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perfume__note__join changes.

  ## Examples

      iex> change_perfume__note__join(perfume__note__join)
      %Ecto.Changeset{source: %Perfume_Note_Join{}}

  """
  def change_perfume__note__join(%Perfume_Note_Join{} = perfume__note__join) do
    Perfume_Note_Join.changeset(perfume__note__join, %{})
  end

  @doc """
  Returns the list of perfume_accord_joins.

  ## Examples

      iex> list_perfume_accord_joins()
      [%Perfume_Accord_Join{}, ...]

  """
  def list_perfume_accord_joins do
    Repo.all(Perfume_Accord_Join)
  end

  @doc """
  Gets a single perfume__accord__join.

  Raises `Ecto.NoResultsError` if the Perfume  accord  join does not exist.

  ## Examples

      iex> get_perfume__accord__join!(123)
      %Perfume_Accord_Join{}

      iex> get_perfume__accord__join!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perfume__accord__join!(id), do: Repo.get!(Perfume_Accord_Join, id)

  @doc """
  Creates a perfume__accord__join.

  ## Examples

      iex> create_perfume__accord__join(%{field: value})
      {:ok, %Perfume_Accord_Join{}}

      iex> create_perfume__accord__join(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perfume__accord__join(attrs \\ %{}) do
    %Perfume_Accord_Join{}
    |> Perfume_Accord_Join.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perfume__accord__join.

  ## Examples

      iex> update_perfume__accord__join(perfume__accord__join, %{field: new_value})
      {:ok, %Perfume_Accord_Join{}}

      iex> update_perfume__accord__join(perfume__accord__join, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perfume__accord__join(%Perfume_Accord_Join{} = perfume__accord__join, attrs) do
    perfume__accord__join
    |> Perfume_Accord_Join.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Perfume_Accord_Join.

  ## Examples

      iex> delete_perfume__accord__join(perfume__accord__join)
      {:ok, %Perfume_Accord_Join{}}

      iex> delete_perfume__accord__join(perfume__accord__join)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perfume__accord__join(%Perfume_Accord_Join{} = perfume__accord__join) do
    Repo.delete(perfume__accord__join)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perfume__accord__join changes.

  ## Examples

      iex> change_perfume__accord__join(perfume__accord__join)
      %Ecto.Changeset{source: %Perfume_Accord_Join{}}

  """
  def change_perfume__accord__join(%Perfume_Accord_Join{} = perfume__accord__join) do
    Perfume_Accord_Join.changeset(perfume__accord__join, %{})
  end
end
