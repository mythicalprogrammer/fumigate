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
end
