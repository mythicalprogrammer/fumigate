defmodule Fumigate.Helpers.ChangesetHelper do
  import Ecto.Changeset


  def put_assoc?(changeset, _atom, nil), do: changeset
  def put_assoc?(changeset, atom, records) do
    changeset
    |> put_assoc(atom, records)
  end

end
