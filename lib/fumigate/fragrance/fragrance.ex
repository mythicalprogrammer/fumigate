defmodule Fumigate.Fragrance do
  @moduledoc """
  The Fragrance context.
  """

  import Ecto.Query, warn: false
  alias Fumigate.Repo
  alias Fumigate.Fragrance.Country
  alias Fumigate.Fragrance.Company_Type
  alias Fumigate.Fragrance.Company_Main_Activity

  def create_company_main_activity(main_activity) do
    Repo.get_by(Company_Main_Activity, main_activity: main_activity) || Repo.insert!(%Company_Main_Activity{main_activity: main_activity})
  end

  def create_company_type(company_type) do
    Repo.get_by(Company_Type, company_type: company_type) || Repo.insert!(%Company_Type{company_type: company_type})
  end

  def create_country(name) do
    Repo.get_by(Country, name: name) || Repo.insert!(%Country{name: name})
  end

  alias Fumigate.Fragrance.Company

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
end
