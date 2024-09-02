defmodule StatsViewer.Workers.FetchDataSet do
  @moduledoc "Background job to clear obsolete files in storage"
  use Oban.Worker, queue: :default

  require Logger


  @path "https://github.com/plotly/datasets/tree/master"
  def perform(%Oban.Job{}) do
    # Tesla.get!(@path)
  #  case Repo.get(SchemaName, path: @path, name: "iris.csv") do

  #  end

    path = @path
    :ok
  end

  def perform(x) do
    Logger.warning("Unknown job format #{inspect(x)}")
    :ok
  end
end
