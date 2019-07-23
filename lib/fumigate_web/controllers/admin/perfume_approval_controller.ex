defmodule FumigateWeb.Admin.PerfumeApprovalController do
  use FumigateWeb, :controller

  alias Fumigate.Approval

  plug Fumigate.Plug.AccordList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.NoteList when action in [:new, :create, :edit, :update]
  plug Fumigate.Plug.CompanyList when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    params = Map.put(params, :page_size, 25)
    page = Approval.list_perfume_approvals_paginate(params) 
    render(conn, "index.html", page: page)
  end
end
