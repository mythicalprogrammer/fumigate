defmodule Fumigate.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :role, :string, default: "user"
    pow_user_fields()

    has_many :perfume_approvals, Fumigate.Approval.PerfumeApproval, foreign_key: :submitter_user_id, references: :id 
    
    has_many :perfumes, Fumigate.Fragrance.Perfume, foreign_key: :submitter_user_id, references: :id 

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset 
    |> pow_changeset(attrs)
    |> changeset_role(attrs)
    |> changeset_username(attrs)
  end

  def changeset_username(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:username])
    |> unique_constraint(:username)
  end

  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:role])
    |> validate_inclusion(:role, ~w(user admin))
  end
end
