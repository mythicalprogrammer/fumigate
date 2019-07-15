defmodule Fumigate.Fragrance.CompanyMainActivity do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "company_main_activities" do
    field :main_activity, :string, null: false

    has_many :companies, Fumigate.Fragrance.Company, foreign_key: :id
    timestamps()
  end

  @doc false
  def changeset(company_main_activity, attrs) do
    company_main_activity
    |> cast(attrs, [:main_activity])
    |> validate_required([:main_activity])
  end

  def alphabetical(query) do
    from c in query, order_by: c.main_activity
  end
end
