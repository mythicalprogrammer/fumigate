defmodule Fumigate.Approval do
  @moduledoc """
  The Approval context.
  """

  import Ecto.Query, warn: false
  alias Fumigate.Repo

  alias Fumigate.Approval.PerfumeApproval

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
end
