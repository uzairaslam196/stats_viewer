defmodule StatsViewer.Repo do
  use Ecto.Repo,
    otp_app: :stats_viewer,
    adapter: Ecto.Adapters.Postgres
end
