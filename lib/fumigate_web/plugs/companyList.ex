defmodule Fumigate.CompanyList do
  import Plug.Conn
  alias Fumigate.Fragrance

  def init(opts), do: opts 

  def call(conn, _opts) do
    assign(conn, :companies, Fragrance.list_alphabetical_companies())
  end
end
