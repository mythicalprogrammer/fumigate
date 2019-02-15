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

  describe "perfumes" do
    alias Fumigate.Fragrance.Perfume

    @valid_attrs %{concentration: "some concentration", day_released: 42, gender: "some gender", month_released: 42, perfume_description: "some perfume_description", perfume_name: "some perfume_name", picture_url: "some picture_url", year_released: 42}
    @update_attrs %{concentration: "some updated concentration", day_released: 43, gender: "some updated gender", month_released: 43, perfume_description: "some updated perfume_description", perfume_name: "some updated perfume_name", picture_url: "some updated picture_url", year_released: 43}
    @invalid_attrs %{concentration: nil, day_released: nil, gender: nil, month_released: nil, perfume_description: nil, perfume_name: nil, picture_url: nil, year_released: nil}

    def perfume_fixture(attrs \\ %{}) do
      {:ok, perfume} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fragrance.create_perfume()

      perfume
    end

    test "list_perfumes/0 returns all perfumes" do
      perfume = perfume_fixture()
      assert Fragrance.list_perfumes() == [perfume]
    end

    test "get_perfume!/1 returns the perfume with given id" do
      perfume = perfume_fixture()
      assert Fragrance.get_perfume!(perfume.id) == perfume
    end

    test "create_perfume/1 with valid data creates a perfume" do
      assert {:ok, %Perfume{} = perfume} = Fragrance.create_perfume(@valid_attrs)
      assert perfume.concentration == "some concentration"
      assert perfume.day_released == 42
      assert perfume.gender == "some gender"
      assert perfume.month_released == 42
      assert perfume.perfume_description == "some perfume_description"
      assert perfume.perfume_name == "some perfume_name"
      assert perfume.picture_url == "some picture_url"
      assert perfume.year_released == 42
    end

    test "create_perfume/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fragrance.create_perfume(@invalid_attrs)
    end

    test "update_perfume/2 with valid data updates the perfume" do
      perfume = perfume_fixture()
      assert {:ok, %Perfume{} = perfume} = Fragrance.update_perfume(perfume, @update_attrs)
      assert perfume.concentration == "some updated concentration"
      assert perfume.day_released == 43
      assert perfume.gender == "some updated gender"
      assert perfume.month_released == 43
      assert perfume.perfume_description == "some updated perfume_description"
      assert perfume.perfume_name == "some updated perfume_name"
      assert perfume.picture_url == "some updated picture_url"
      assert perfume.year_released == 43
    end

    test "update_perfume/2 with invalid data returns error changeset" do
      perfume = perfume_fixture()
      assert {:error, %Ecto.Changeset{}} = Fragrance.update_perfume(perfume, @invalid_attrs)
      assert perfume == Fragrance.get_perfume!(perfume.id)
    end

    test "delete_perfume/1 deletes the perfume" do
      perfume = perfume_fixture()
      assert {:ok, %Perfume{}} = Fragrance.delete_perfume(perfume)
      assert_raise Ecto.NoResultsError, fn -> Fragrance.get_perfume!(perfume.id) end
    end

    test "change_perfume/1 returns a perfume changeset" do
      perfume = perfume_fixture()
      assert %Ecto.Changeset{} = Fragrance.change_perfume(perfume)
    end
  end
end
