defmodule Fumigate.AccordList do
  import Plug.Conn
  alias Fumigate.Fragrance

  def init(opts), do: opts 

  def call(conn, _opts) do
    assign(conn, :accords, Fragrance.list_alphabetical_accords())
  end
end
