defmodule AccountingSystem.PeriodHandler do
  @moduledoc """
  The AccountingSystems context.
  """

  import Ecto.Query, warn: false
  alias AccountingSystem.Repo

  alias AccountingSystem.PeriodSchema

  @doc """
  Returns the list of periods.

  ## Examples

      iex> list_periods()
      [%PeriodSchema{}, ...]

  """
  def list_periods do
    Repo.all(PeriodSchema)
  end

  @doc """
  Gets a single period.

  Raises `Ecto.NoResultsError` if the Period does not exist.

  ## Examples

      iex> get_period!(123)
      %PeriodSchema{}

      iex> get_period!(456)
      ** (Ecto.NoResultsError)

  """
  def get_period!(id), do: Repo.get!(PeriodSchema, id)

  @doc """
  Creates a period.

  ## Examples

      iex> create_period(%{field: value})
      {:ok, %PeriodSchema{}}

      iex> create_period(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_period(attrs \\ %{}) do
    %PeriodSchema{}
    |> PeriodSchema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a period.

  ## Examples

      iex> update_period(period, %{field: new_value})
      {:ok, %PeriodSchema{}}

      iex> update_period(period, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_period(%PeriodSchema{} = period, attrs) do
    period
    |> PeriodSchema.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a period.

  ## Examples

      iex> delete_period(period)
      {:ok, %PeriodSchema{}}

      iex> delete_period(period)
      {:error, %Ecto.Changeset{}}

  """
  def delete_period(%PeriodSchema{} = period) do
    Repo.delete(period)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking period changes.

  ## Examples

      iex> change_period(period)
      %Ecto.Changeset{source: %PeriodSchema{}}

  """
  def change_period(%PeriodSchema{} = period) do
    PeriodSchema.changeset(period, %{})
  end
end
