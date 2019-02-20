defmodule Fumigate.PerfumeList do
  import Plug.Conn
  alias Fumigate.Fragrance

  def init(opts), do: opts 

  def call(conn, _opts) do
    assign(conn, :perfumes, Fragrance.list_alphabetical_perfumes())
  end
end
