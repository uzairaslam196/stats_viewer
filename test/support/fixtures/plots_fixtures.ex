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
end
