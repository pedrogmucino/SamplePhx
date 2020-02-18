defmodule AccountingSystem.SeriesHandler do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.{
    Repo,
    SeriesSchema,
    GetSeriesQuery,
    GetSpecificSeriesQuery
  }


  alias AccountingSystem.SeriesSchema

  @doc """
  Returns the list of series.

  ## Examples

      iex> list_series()
      [%Series{}, ...]

  """
  def list_series do
    Repo.all(SeriesSchema)
  end

  def get_series do
    GetSeriesQuery.new
    |> Repo.all
  end

  def get_serie(id) do
    GetSpecificSeriesQuery.new(id)
    |> Repo.one
  end

  @doc """
  Gets a single series.

  Raises `Ecto.NoResultsError` if the Series does not exist.

  ## Examples

      iex> get_series!(123)
      %Series{}

      iex> get_series!(456)
      ** (Ecto.NoResultsError)

  """
  def get_series!(id), do: Repo.get!(SeriesSchema, id)

  @doc """
  Creates a series.

  ## Examples

      iex> create_series(%{field: value})
      {:ok, %Series{}}

      iex> create_series(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_series(attrs \\ %{}) do
    %SeriesSchema{}
    |> SeriesSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a series.

  ## Examples

      iex> update_series(series, %{field: new_value})
      {:ok, %Series{}}

      iex> update_series(series, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_series(%SeriesSchema{} = series, attrs) do
    series
    |> SeriesSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a series.

  ## Examples

      iex> delete_series(series)
      {:ok, %Series{}}

      iex> delete_series(series)
      {:error, %Ecto.Changeset{}}

  """
  def delete_series(%SeriesSchema{} = series) do
    Repo.delete(series)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking series changes.

  ## Examples

      iex> change_series(series)
      %Ecto.Changeset{source: %Series{}}

  """
  def change_series(%SeriesSchema{} = series) do
    SeriesSchema.changeset(series, %{})
  end
end
