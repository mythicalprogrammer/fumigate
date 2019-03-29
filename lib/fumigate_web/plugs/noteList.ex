defmodule Fumigate.Plug.NoteList do
  import Plug.Conn
  alias Fumigate.Fragrance

  def init(opts), do: opts 

  def call(conn, _opts) do
    assign(conn, :notes, Fragrance.list_alphabetical_notes())
  end
end
