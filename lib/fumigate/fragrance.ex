defmodule Fumigate.Fragrance do
  @moduledoc """
  The Fragrance context.
  """

  import Ecto.Query, warn: false
  alias Fumigate.Repo

  alias Fumigate.Fragrance.Perfume

  @doc """
  Returns the list of perfumes.

  ## Examples

      iex> list_perfumes()
      [%Perfume{}, ...]

  """
  def list_perfumes do
    Repo.all(Perfume)
  end

  @doc """
  Gets a single perfume.

  Raises `Ecto.NoResultsError` if the Perfume does not exist.

  ## Examples

      iex> get_perfume!(123)
      %Perfume{}

      iex> get_perfume!(456)
      ** (Ecto.NoResultsError)

  """
  def get_perfume!(id), do: Repo.get!(Perfume, id)

  @doc """
  Creates a perfume.

  ## Examples

      iex> create_perfume(%{field: value})
      {:ok, %Perfume{}}

      iex> create_perfume(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_perfume(attrs \\ %{}) do
    %Perfume{}
    |> Perfume.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a perfume.

  ## Examples

      iex> update_perfume(perfume, %{field: new_value})
      {:ok, %Perfume{}}

      iex> update_perfume(perfume, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_perfume(%Perfume{} = perfume, attrs) do
    perfume
    |> Perfume.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Perfume.

  ## Examples

      iex> delete_perfume(perfume)
      {:ok, %Perfume{}}

      iex> delete_perfume(perfume)
      {:error, %Ecto.Changeset{}}

  """
  def delete_perfume(%Perfume{} = perfume) do
    Repo.delete(perfume)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking perfume changes.

  ## Examples

      iex> change_perfume(perfume)
      %Ecto.Changeset{source: %Perfume{}}

  """
  def change_perfume(%Perfume{} = perfume) do
    Perfume.changeset(perfume, %{})
  end
end
