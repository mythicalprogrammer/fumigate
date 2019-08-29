defmodule Fumigate.Helpers.DebugHelper do
  def print_sql(queryable) do
	IO.inspect(Ecto.Adapters.SQL.to_sql(:all, Repo, queryable))
	queryable
  end
end
