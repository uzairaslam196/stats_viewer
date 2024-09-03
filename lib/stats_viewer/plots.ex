defmodule StatsViewer.Plots do
  @moduledoc """
  The Plots context.
  """

  import Ecto.Query, warn: false
  alias StatsViewer.Repo

  alias StatsViewer.Plots.Plot
  alias StatsViewer.Plots.CSVFile

  @doc """
  Returns the list of plots.

  ## Examples

      iex> list_plots()
      [%Plot{}, ...]

  """
  def list_plots do
    Repo.all(Plot)
  end

  @doc """
  Gets a single plot.

  Raises `Ecto.NoResultsError` if the Plot does not exist.

  ## Examples

      iex> get_plot!(123)
      %Plot{}

      iex> get_plot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plot!(id), do: Repo.get!(Plot, id)

  @doc """
  Creates a plot.

  ## Examples

      iex> create_plot(%{field: value})
      {:ok, %Plot{}}

      iex> create_plot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plot(attrs \\ %{}) do
    %Plot{}
    |> Plot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plot.

  ## Examples

      iex> update_plot(plot, %{field: new_value})
      {:ok, %Plot{}}

      iex> update_plot(plot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plot(%Plot{} = plot, attrs) do
    plot
    |> Plot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plot.

  ## Examples

      iex> delete_plot(plot)
      {:ok, %Plot{}}

      iex> delete_plot(plot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plot(%Plot{} = plot) do
    Repo.delete(plot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plot changes.

  ## Examples

      iex> change_plot(plot)
      %Ecto.Changeset{data: %Plot{}}

  """
  def change_plot(%Plot{} = plot, attrs \\ %{}) do
    Plot.changeset(plot, attrs)
  end

  @doc """
  Returns the list of csv_files.

  ## Examples

      iex> list_csv_files()
      [%CSVFile{}, ...]

  """
  def list_csv_files do
    Repo.all(CSVFile)
  end

  @doc """
  Gets a single csv_file.

  Raises `Ecto.NoResultsError` if the Csv file does not exist.

  ## Examples

      iex> get_csv_file!(123)
      %CSVFile{}

      iex> get_csv_file!(456)
      ** (Ecto.NoResultsError)

  """
  def get_csv_file!(id), do: Repo.get!(CSVFile, id)

  @doc """
  Creates a csv_file.

  ## Examples

      iex> create_csv_file(%{field: value})
      {:ok, %CSVFile{}}

      iex> create_csv_file(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_csv_file(attrs \\ %{}) do
    %CSVFile{}
    |> CSVFile.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a csv_file.

  ## Examples

      iex> update_csv_file(csv_file, %{field: new_value})
      {:ok, %CSVFile{}}

      iex> update_csv_file(csv_file, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_csv_file(%CSVFile{} = csv_file, attrs) do
    csv_file
    |> CSVFile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a csv_file.

  ## Examples

      iex> delete_csv_file(csv_file)
      {:ok, %CSVFile{}}

      iex> delete_csv_file(csv_file)
      {:error, %Ecto.Changeset{}}

  """
  def delete_csv_file(%CSVFile{} = csv_file) do
    Repo.delete(csv_file)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking csv_file changes.

  ## Examples

      iex> change_csv_file(csv_file)
      %Ecto.Changeset{data: %CSVFile{}}

  """
  def change_csv_file(%CSVFile{} = csv_file, attrs \\ %{}) do
    CSVFile.changeset(csv_file, attrs)
  end
end
