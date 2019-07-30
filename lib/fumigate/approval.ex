defmodule Fumigate.Approval do
  @moduledoc """
  The Approval context.
  """

  import Ecto.Query, warn: false
  alias Fumigate.Repo

  alias Fumigate.Approval.PerfumeApproval
  alias Fumigate.Approval.PerfumeApprovalAccordJoin
  alias Fumigate.Approval.PerfumeApprovalCompanyJoin
  alias Fumigate.Approval.PerfumeApprovalNoteJoin
  alias Fumigate.Fragrance.Note
  alias Fumigate.Fragrance.Perfume

  def change_perfume(%PerfumeApproval{} = perfume) do
    PerfumeApproval.changeset(perfume, %{})
  end

  def change_perfume_approval(%PerfumeApproval{} = perfume) do
    PerfumeApproval.changeset(perfume, %{})
  end

  def create_perfume_approval(attrs \\ %{}) do
    %PerfumeApproval{}
    |> PerfumeApproval.changeset(attrs)
    |> Repo.insert()
  end

  def list_perfume_approvals_paginate(params) do
    PerfumeApproval
    |> PerfumeApproval.get_all_perfume_approvals_preload() 
    |> Repo.paginate(params)
  end 

  def get_perfume!(id), do: Repo.get!(PerfumeApproval, id)

  def get_all_top_notes_by_perfume_id(id) do
      top_note_ids = select_all_top_notes_by_perfume_id(id) 
      Note
      |> Note.get_all_by_id(top_note_ids) 
      |> Repo.all()
  end

  def get_all_middle_notes_by_perfume_id(id) do
      middle_note_ids = select_all_middle_notes_by_perfume_id(id) 
      Note
      |> Note.get_all_by_id(middle_note_ids) 
      |> Repo.all()
  end

  def get_all_base_notes_by_perfume_id(id) do
      base_note_ids = select_all_base_notes_by_perfume_id(id) 
      Note
      |> Note.get_all_by_id(base_note_ids) 
      |> Repo.all()
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
    PerfumeApprovalNoteJoin
    |> PerfumeApprovalNoteJoin.get_all_notes_by_perfume_approval_id(perfume_id, pyramid_note) 
    |> Repo.all()
  end

  def select_all_companies_by_perfume_id(id) do
    PerfumeApprovalCompanyJoin
    |> PerfumeApprovalCompanyJoin.get_all_companies_by_perfume_id(id) 
    |> Repo.all()
  end

  def select_all_accords_by_perfume_id(perfume_id) do
    PerfumeApprovalAccordJoin
    |> PerfumeApprovalAccordJoin.get_all_accords_by_perfume_id(perfume_id) 
    |> Repo.all()
  end

  def update_perfume(%PerfumeApproval{} = perfume, attrs) do
    perfume
    |> PerfumeApproval.changeset(attrs)
    |> Repo.update()
  end

  def delete_all_company_joins_by_perfume_id(id) do
    queryable = PerfumeApprovalCompanyJoin |> PerfumeApprovalCompanyJoin.delete_all_company_joins_by_perfume_id(id) 
    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:delete_all, queryable)
    |> Repo.transaction()
  end

  def delete_all_note_joins_by_perfume_id(perfume_id, pyramid_note) do
    queryable = PerfumeApprovalNoteJoin |> PerfumeApprovalNoteJoin.delete_all_note_joins_by_perfume_approval_id(perfume_id, pyramid_note) 
    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:delete_all, queryable)
    |> Repo.transaction()
  end

  def delete_all_accord_joins_by_perfume_id(perfume_id) do
    queryable = PerfumeApprovalAccordJoin |> PerfumeApprovalAccordJoin.delete_all_accord_joins_by_perfume_id(perfume_id) 
    Ecto.Multi.new()
    |> Ecto.Multi.delete_all(:delete_all, queryable)
    |> Repo.transaction()
  end

  def insert_all_accords(accords, perfume) do
    records = accords |> Enum.map(fn(x) -> [perfume_approval_id: perfume.id, accord_id: String.to_integer(x), inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second), updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)] end)
    PerfumeApprovalAccordJoin
    |> Repo.insert_all(records)
  end

  def insert_all_notes_by_perfume_id(notes, perfume_id, pyramid_note) do
    records = notes |> Enum.map(fn(x) -> [perfume_approval_id: perfume_id, note_id: String.to_integer(x), pyramid_note: pyramid_note, inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second), updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)] end)
    PerfumeApprovalNoteJoin
    |> Repo.insert_all(records)
  end

  def insert_all_companies(company_id, perfume_id) do
    records = company_id |> Enum.map(fn(x) -> [perfume_approval_id: perfume_id, company_id: String.to_integer(x), inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second), updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)] end)
    PerfumeApprovalCompanyJoin
    |> Repo.insert_all(records)
  end

  def find_perfume_by_name_con_comp(name, concentration, companies) do
    companies_list = Enum.map(companies, fn company -> company.company_name end)
    Perfume
    |> Perfume.get_all_perfume_by_perfume_name_con_comp(name, concentration, companies_list) 
    #|> print_sql()
    |> Repo.all()
  end

  def print_sql(queryable) do
	IO.inspect(Ecto.Adapters.SQL.to_sql(:all, Repo, queryable))
	queryable
  end

  def delete_perfume(%PerfumeApproval{} = perfume) do
    Repo.delete(perfume)
  end
end
