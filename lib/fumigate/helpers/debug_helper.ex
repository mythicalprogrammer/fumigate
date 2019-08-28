defmodule Fumigate.Helpers.DebugHelper do
  import Ecto.Changeset

  def print_sql(queryable) do
	IO.inspect(Ecto.Adapters.SQL.to_sql(:all, Repo, queryable))
	queryable
  end
end
