defmodule StatsViewerWeb.PlotLive.Index do
  use StatsViewerWeb, :live_view

  alias StatsViewer.Plots
  alias StatsViewer.Plots.Plot

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:plots, Plots.list_plots(socket.assigns.current_user.id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(%{assigns: %{current_user: user}} = socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Plot")
    |> assign(:plot, Plots.get_plot_by!(user, id))
  end

  defp apply_action(%{assigns: %{current_user: user}} = socket, :share, %{"id" => id}) do
    socket
    |> assign(:page_title, "Share Plot with other users")
    |> assign(:plot, Plots.get_plot_by!(user, id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Plot")
    |> assign(:plot, %Plot{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:plot, nil)
  end

  @impl true
  def handle_info({StatsViewerWeb.PlotLive.FormComponent, {:saved, plot}}, socket) do
    {:noreply, stream_insert(socket, :plots, plot)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, %{assigns: %{current_user: user}} = socket) do
    plot = Plots.get_plot_by!(user, id)
    {:ok, _} = Plots.delete_plot(plot)

    {:noreply, stream_delete(socket, :plots, plot)}
  end
end
