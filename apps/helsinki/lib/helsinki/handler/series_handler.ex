defmodule AccountingSystem.SeriesHandler do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.{
    Repo,
    SeriesSchema,
    GetSeriesQuery,
    GetSpecificSeriesQuery,
    GetPolicySerialQuery
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

  def get_serial(fiscal_exercise, policy_type) do
    serial_map =
    GetPolicySerialQuery.new(fiscal_exercise, policy_type)
    |> Repo.one!
    Map.get(serial_map, :serial)
    |> get_number(serial_map, fiscal_exercise)
  end

  defp get_number(serial, serial_map, fiscal_exercise) do
    series_increment(serial_map.id)

    serial_map
    |> Map.get(:current_number)
    |> serial_format(serial, fiscal_exercise)
  end

  defp serial_format(number, serial, fiscal_exercise) do
    # serial <> fiscal_exercise <> "-" <> Integer.to_string(number + 1)
    %{serial: serial <> fiscal_exercise, number: number + 1}
  end

  defp series_increment(series_id) do
    series = Repo.get(SeriesSchema, series_id)
    attrs = %{"current_number" => series.current_number + 1}
    series
    |> SeriesSchema.changeset(attrs)
    |> Repo.update()
  end
end
