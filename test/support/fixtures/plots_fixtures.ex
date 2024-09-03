defmodule StatsViewer.PlotsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StatsViewer.Plots` context.
  """

  @doc """
  Generate a plot.
  """
  def plot_fixture(attrs \\ %{}) do
    {:ok, plot} =
      attrs
      |> Enum.into(%{
        dataset: "some dataset",
        expression: "some expression",
        name: "some name"
      })
      |> StatsViewer.Plots.create_plot()

    plot
  end

  @doc """
  Generate a csv_file.
  """
  def csv_file_fixture(attrs \\ %{}) do
    {:ok, csv_file} =
      attrs
      |> Enum.into(%{})
      |> StatsViewer.Plots.create_csv_file()

    csv_file
  end
end
