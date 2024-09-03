defmodule StatsViewer.Workers.FetchDataSet do
  @moduledoc "Background job to fetch latest data"
  use Oban.Worker, queue: :default

  alias StatsViewer.Plots.CSVFile
  alias StatsViewer.Repo
  require Logger

  @path "https://api.github.com/repos/plotly/datasets/contents"
  @options [timeout: 20_000, recv_timeout: 20_000]
  @headers [{"Accept", "application/vnd.github.v3+json"}]

  @impl Oban.Worker
  def perform(_) do
    sync_csv_data()
  end

  def sync_csv_data() do
    case HTTPoison.get(@path, @headers, @options) do
      {:ok, %{status_code: 200, body: body}} ->
        {:ok, decoded_body} = Poison.decode(body)

        decoded_body
        |> Task.async_stream(
          fn map ->
            if Path.extname(map["name"]) == ".csv" do
              case fetch_headers(map["download_url"]) do
                {:ok, headers} ->
                  save_csv!(%{path: map["download_url"], name: map["name"], headers: headers})

                {:error, error} ->
                  Logger.warning(
                    "File: #{map["name"]}, error fetching headers: #{inspect(error)}"
                  )
              end
            end
          end,
          timeout: 60000
        )
        |> Stream.run()

      error ->
        Logger.error("error fetching repo: #{inspect(error)}")
        :error
    end
  end

  defp fetch_headers(url) do
    try do
      {:ok, %{status_code: 206, body: body}} =
        HTTPoison.get(url, @headers ++ [{"Range", "bytes=0-1023"}], @options)

      {:ok,
       body
       |> NimbleCSV.RFC4180.parse_string(skip_headers: false)
       |> List.first()
       |> Enum.take(15)}
    rescue
      error ->
        {:error, error}
    end
  end

  defp save_csv!(attrs) do
    case Repo.get_by(CSVFile, path: attrs.path, name: attrs.name) do
      %CSVFile{} = csv ->
        csv
        |> CSVFile.changeset(attrs)
        |> Repo.update!()

      _ ->
        %CSVFile{}
        |> CSVFile.changeset(attrs)
        |> Repo.insert!(on_conflict: :replace_all, conflict_target: [:path, :name])
    end
  end
end
