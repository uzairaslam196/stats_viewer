defmodule StatsViewerWeb.PlotLive.Show do
  use StatsViewerWeb, :live_view

  alias StatsViewer.Plots

  @impl true
  def mount(_params, _session, socket) do


    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:plot, Plots.get_plot!(id))}
  end

  defp page_title(:show), do: "Show Plot"
  defp page_title(:edit), do: "Edit Plot"

  def test do
    HTTPoison.get(
      "https://raw.githubusercontent.com/plotly/datasets/master/iris.csv",
      [{"Range", "bytes=0-1023"}],
      [timeout: 50_000, recv_timeout: 50_000]
    )
    |> elem(1)
    |> Map.get(:body)
    |> String.split("\n")
    |> List.first()
    |> String.split(",")
    |> IO.inspect()
  end
end
