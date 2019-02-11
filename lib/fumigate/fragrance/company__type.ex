defmodule Fumigate.Fragrance.Company_Type do
  use Ecto.Schema
  import Ecto.Changeset


  schema "company_types" do
    field :company_type, :string

    timestamps()
  end

  @doc false
  def changeset(company__type, attrs) do
    company__type
    |> cast(attrs, [:company_type])
    |> validate_required([:company_type])
  end
end
