defmodule StatsViewer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias StatsViewer.Workers.FetchDataSet
  @impl true
  def start(_type, _args) do
    children = [
      StatsViewerWeb.Telemetry,
      StatsViewer.Repo,
      {DNSCluster, query: Application.get_env(:stats_viewer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StatsViewer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: StatsViewer.Finch},
      # Start a worker by calling: StatsViewer.Worker.start_link(arg)
      # {StatsViewer.Worker, arg},
      # Start to serve requests, typically the last entry
      StatsViewerWeb.Endpoint,
      {Oban, Application.fetch_env!(:stats_viewer, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StatsViewer.Supervisor]
    sup = Supervisor.start_link(children, opts)
    schedule_worker()
    sup
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StatsViewerWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp schedule_worker do
    FetchDataSet.new(%{scheduled_at: DateTime.utc_now()})
    |> Oban.insert!()
  end
end
