defmodule AccountingSystem.QueryPeriodHandler do
  @moduledoc """
  The AccountingSystems context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.QueryPeriodSchema

  @doc """
  Returns the list of queryperiods.

  ## Examples

      iex> list_queryperiods()
      [%QueryPeriodSchema{}, ...]

  """
  def list_queryperiods do
    Repo.all(QueryPeriodSchema)
  end

  @doc """
  Gets a single query_period.

  Raises `Ecto.NoResultsError` if the Query period does not exist.

  ## Examples

      iex> get_query_period!(123)
      %QueryPeriodSchema{}

      iex> get_query_period!(456)
      ** (Ecto.NoResultsError)

  """
  def get_query_period!(id), do: Repo.get!(QueryPeriodSchema, id)

  @doc """
  Creates a query_period.

  ## Examples

      iex> create_query_period(%{field: value})
      {:ok, %QueryPeriodSchema{}}

      iex> create_query_period(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_query_period(attrs \\ %{}) do
    %QueryPeriodSchema{}
    |> QueryPeriodSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a query_period.

  ## Examples

      iex> update_query_period(query_period, %{field: new_value})
      {:ok, %QueryPeriodSchema{}}

      iex> update_query_period(query_period, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_query_period(%QueryPeriodSchema{} = query_period, attrs) do
    query_period
    |> QueryPeriodSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a query_period.

  ## Examples

      iex> delete_query_period(query_period)
      {:ok, %QueryPeriodSchema{}}

      iex> delete_query_period(query_period)
      {:error, %Ecto.Changeset{}}

  """
  def delete_query_period(%QueryPeriodSchema{} = query_period) do
    Repo.delete(query_period)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking query_period changes.

  ## Examples

      iex> change_query_period(query_period)
      %Ecto.Changeset{source: %QueryPeriodSchema{}}

  """
  def change_query_period(%QueryPeriodSchema{} = query_period) do
    QueryPeriodSchema.changeset(query_period, %{})
  end
end
