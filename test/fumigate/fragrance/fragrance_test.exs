defmodule Fumigate.FragranceTest do
  use Fumigate.DataCase

  alias Fumigate.Fragrance

  describe "companies" do
    alias Fumigate.Fragrance.Company

    @valid_attrs %{company_description: "some company_description", company_name: "some company_name", company_url: "some company_url", day_established: 42, logo_url: "some logo_url", month_established: 42, year_established: 42}
    @update_attrs %{company_description: "some updated company_description", company_name: "some updated company_name", company_url: "some updated company_url", day_established: 43, logo_url: "some updated logo_url", month_established: 43, year_established: 43}
    @invalid_attrs %{company_description: nil, company_name: nil, company_url: nil, day_established: nil, logo_url: nil, month_established: nil, year_established: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fragrance.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Fragrance.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Fragrance.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Fragrance.create_company(@valid_attrs)
      assert company.company_description == "some company_description"
      assert company.company_name == "some company_name"
      assert company.company_url == "some company_url"
      assert company.day_established == 42
      assert company.logo_url == "some logo_url"
      assert company.month_established == 42
      assert company.year_established == 42
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fragrance.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Fragrance.update_company(company, @update_attrs)
      assert company.company_description == "some updated company_description"
      assert company.company_name == "some updated company_name"
      assert company.company_url == "some updated company_url"
      assert company.day_established == 43
      assert company.logo_url == "some updated logo_url"
      assert company.month_established == 43
      assert company.year_established == 43
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Fragrance.update_company(company, @invalid_attrs)
      assert company == Fragrance.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Fragrance.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Fragrance.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Fragrance.change_company(company)
    end
  end
end
