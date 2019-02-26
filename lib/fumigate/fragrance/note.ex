defmodule Fumigate.Fragrance.Note do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "notes" do
    field :note_name, :string

    timestamps()
    many_to_many :perfumes, Fumigate.Fragrance.Perfume, join_through: Fumigate.Fragrance.Perfume_Note_Join
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:note_name])
    |> validate_required([:note_name])
  end

  def alphabetical(query) do
    from c in query, order_by: c.note_name
  end

  def get_all_by_id(query, ids) do
    from c in query,
    order_by: c.note_name,
    where: c.id in ^ids
  end
end
