defmodule StatsViewerWeb.PlotLive.Shared do
  use StatsViewerWeb, :live_view

  alias StatsViewer.Plots
  alias StatsViewer.Plots.Plot

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:plots, Plots.get_shared_plots(socket.assigns.current_user.id))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex gap-4 h-screen w-full">
      <div class="w-full p-8 border">
        <.header>
          Shared Plots with you
        </.header>

        <.table
          id="plots"
          rows={@streams.plots}
          row_click={fn {_id, plot} -> JS.navigate(~p"/plots/#{plot}") end}
        >
          <:col :let={{_id, plot}} label="Name"><%= plot.name %></:col>
          <:col :let={{_id, plot}} label="Dataset"><%= plot.dataset %></:col>
          <:col :let={{_id, plot}} label="Expression"><%= plot.expression %></:col>
        </.table>
      </div>
    </div>
    """
  end
end
