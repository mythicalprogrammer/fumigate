defmodule Fumigate.Approval do
  @moduledoc """
  The Approval context.
  """

  import Ecto.Query, warn: false
  alias Fumigate.Repo

  alias Fumigate.Approval.PerfumeApproval
  alias Fumigate.Approval.PerfumeApprovalNoteJoin
  alias Fumigate.Fragrance.Note

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
end
