defmodule Fumigate.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :permissions, :map

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :name, :password, :email, :permissions])
    |> validate_required([:username, :email, :password])
    |> validate_changeset
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :username, :name, :password])
    |> validate_required([:email, :username, :password])
    |> validate_changeset
  end

  defp validate_changeset(struct) do
    struct
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> generate_password_hash
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  defp generate_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
