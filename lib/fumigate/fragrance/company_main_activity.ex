defmodule Fumigate.Fragrance.Company_Main_Activity do
  use Ecto.Schema
  import Ecto.Changeset


  schema "company_main_activities" do
    field :main_activity, :string, null: false

    has_many :companies, Fumigate.Fragrance.Company
    timestamps()
  end

  @doc false
  def changeset(company_main_activity, attrs) do
    company_main_activity
    |> cast(attrs, [:main_activity])
    |> validate_required([:main_activity])
  end
end
