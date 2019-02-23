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

  describe "perfume_company_joins" do
    alias Fumigate.Fragrance.Perfume_Company_Join

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def perfume__company__join_fixture(attrs \\ %{}) do
      {:ok, perfume__company__join} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fragrance.create_perfume__company__join()

      perfume__company__join
    end

    test "list_perfume_company_joins/0 returns all perfume_company_joins" do
      perfume__company__join = perfume__company__join_fixture()
      assert Fragrance.list_perfume_company_joins() == [perfume__company__join]
    end

    test "get_perfume__company__join!/1 returns the perfume__company__join with given id" do
      perfume__company__join = perfume__company__join_fixture()
      assert Fragrance.get_perfume__company__join!(perfume__company__join.id) == perfume__company__join
    end

    test "create_perfume__company__join/1 with valid data creates a perfume__company__join" do
      assert {:ok, %Perfume_Company_Join{} = perfume__company__join} = Fragrance.create_perfume__company__join(@valid_attrs)
    end

    test "create_perfume__company__join/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fragrance.create_perfume__company__join(@invalid_attrs)
    end

    test "update_perfume__company__join/2 with valid data updates the perfume__company__join" do
      perfume__company__join = perfume__company__join_fixture()
      assert {:ok, %Perfume_Company_Join{} = perfume__company__join} = Fragrance.update_perfume__company__join(perfume__company__join, @update_attrs)
    end

    test "update_perfume__company__join/2 with invalid data returns error changeset" do
      perfume__company__join = perfume__company__join_fixture()
      assert {:error, %Ecto.Changeset{}} = Fragrance.update_perfume__company__join(perfume__company__join, @invalid_attrs)
      assert perfume__company__join == Fragrance.get_perfume__company__join!(perfume__company__join.id)
    end

    test "delete_perfume__company__join/1 deletes the perfume__company__join" do
      perfume__company__join = perfume__company__join_fixture()
      assert {:ok, %Perfume_Company_Join{}} = Fragrance.delete_perfume__company__join(perfume__company__join)
      assert_raise Ecto.NoResultsError, fn -> Fragrance.get_perfume__company__join!(perfume__company__join.id) end
    end

    test "change_perfume__company__join/1 returns a perfume__company__join changeset" do
      perfume__company__join = perfume__company__join_fixture()
      assert %Ecto.Changeset{} = Fragrance.change_perfume__company__join(perfume__company__join)
    end
  end

  describe "accords" do
    alias Fumigate.Fragrance.Accord

    @valid_attrs %{accord_name: "some accord_name"}
    @update_attrs %{accord_name: "some updated accord_name"}
    @invalid_attrs %{accord_name: nil}

    def accord_fixture(attrs \\ %{}) do
      {:ok, accord} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fragrance.create_accord()

      accord
    end

    test "list_accords/0 returns all accords" do
      accord = accord_fixture()
      assert Fragrance.list_accords() == [accord]
    end

    test "get_accord!/1 returns the accord with given id" do
      accord = accord_fixture()
      assert Fragrance.get_accord!(accord.id) == accord
    end

    test "create_accord/1 with valid data creates a accord" do
      assert {:ok, %Accord{} = accord} = Fragrance.create_accord(@valid_attrs)
      assert accord.accord_name == "some accord_name"
    end

    test "create_accord/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fragrance.create_accord(@invalid_attrs)
    end

    test "update_accord/2 with valid data updates the accord" do
      accord = accord_fixture()
      assert {:ok, %Accord{} = accord} = Fragrance.update_accord(accord, @update_attrs)
      assert accord.accord_name == "some updated accord_name"
    end

    test "update_accord/2 with invalid data returns error changeset" do
      accord = accord_fixture()
      assert {:error, %Ecto.Changeset{}} = Fragrance.update_accord(accord, @invalid_attrs)
      assert accord == Fragrance.get_accord!(accord.id)
    end

    test "delete_accord/1 deletes the accord" do
      accord = accord_fixture()
      assert {:ok, %Accord{}} = Fragrance.delete_accord(accord)
      assert_raise Ecto.NoResultsError, fn -> Fragrance.get_accord!(accord.id) end
    end

    test "change_accord/1 returns a accord changeset" do
      accord = accord_fixture()
      assert %Ecto.Changeset{} = Fragrance.change_accord(accord)
    end
  end

  describe "notes" do
    alias Fumigate.Fragrance.Note

    @valid_attrs %{note_name: "some note_name"}
    @update_attrs %{note_name: "some updated note_name"}
    @invalid_attrs %{note_name: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fragrance.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Fragrance.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Fragrance.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Fragrance.create_note(@valid_attrs)
      assert note.note_name == "some note_name"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fragrance.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, %Note{} = note} = Fragrance.update_note(note, @update_attrs)
      assert note.note_name == "some updated note_name"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Fragrance.update_note(note, @invalid_attrs)
      assert note == Fragrance.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Fragrance.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Fragrance.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Fragrance.change_note(note)
    end
  end

  describe "perfume_note_joins" do
    alias Fumigate.Fragrance.Perfume_Note_Join

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def perfume__note__join_fixture(attrs \\ %{}) do
      {:ok, perfume__note__join} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Fragrance.create_perfume__note__join()

      perfume__note__join
    end

    test "list_perfume_note_joins/0 returns all perfume_note_joins" do
      perfume__note__join = perfume__note__join_fixture()
      assert Fragrance.list_perfume_note_joins() == [perfume__note__join]
    end

    test "get_perfume__note__join!/1 returns the perfume__note__join with given id" do
      perfume__note__join = perfume__note__join_fixture()
      assert Fragrance.get_perfume__note__join!(perfume__note__join.id) == perfume__note__join
    end

    test "create_perfume__note__join/1 with valid data creates a perfume__note__join" do
      assert {:ok, %Perfume_Note_Join{} = perfume__note__join} = Fragrance.create_perfume__note__join(@valid_attrs)
    end

    test "create_perfume__note__join/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fragrance.create_perfume__note__join(@invalid_attrs)
    end

    test "update_perfume__note__join/2 with valid data updates the perfume__note__join" do
      perfume__note__join = perfume__note__join_fixture()
      assert {:ok, %Perfume_Note_Join{} = perfume__note__join} = Fragrance.update_perfume__note__join(perfume__note__join, @update_attrs)
    end

    test "update_perfume__note__join/2 with invalid data returns error changeset" do
      perfume__note__join = perfume__note__join_fixture()
      assert {:error, %Ecto.Changeset{}} = Fragrance.update_perfume__note__join(perfume__note__join, @invalid_attrs)
      assert perfume__note__join == Fragrance.get_perfume__note__join!(perfume__note__join.id)
    end

    test "delete_perfume__note__join/1 deletes the perfume__note__join" do
      perfume__note__join = perfume__note__join_fixture()
      assert {:ok, %Perfume_Note_Join{}} = Fragrance.delete_perfume__note__join(perfume__note__join)
      assert_raise Ecto.NoResultsError, fn -> Fragrance.get_perfume__note__join!(perfume__note__join.id) end
    end

    test "change_perfume__note__join/1 returns a perfume__note__join changeset" do
      perfume__note__join = perfume__note__join_fixture()
      assert %Ecto.Changeset{} = Fragrance.change_perfume__note__join(perfume__note__join)
    end
  end
end
