defmodule StatsViewerWeb.PlotLive.CSVFiles do
  use StatsViewerWeb, :live_view
  alias StatsViewer.Plots

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:csv_files, Plots.list_csv_files())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="w-full p-8 border-x border-t">
      <.header>
        All Available CSVs On Source Repo
      </.header>

      <div class="h-screen overflow-y-auto">
        <.table id="plots" rows={@streams.csv_files}>
          <:col :let={{_id, csv_file}} label="CSV File Name"><%= csv_file.name %></:col>
          <:col :let={{_id, csv_file}} label="Columns">
            <%= Enum.join(csv_file.headers, ", ") %>
          </:col>
          <:action :let={{_id, plot}}>
            <div class="sr-only">
              <.link navigate={~p"/plots/#{plot}"}>Show</.link>
            </div>
          </:action>
        </.table>
      </div>
    </div>
    """
  end
end
