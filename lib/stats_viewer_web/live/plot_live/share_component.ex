defmodule StatsViewerWeb.PlotLive.ShareComponent do
  use StatsViewerWeb, :live_component

  alias StatsViewer.Plots
  alias Plots.PlotUser

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <%!-- <:subtitle>Share with user.</:subtitle> --%>
      </.header>

      <.simple_form
        for={@form}
        id="plot-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:user_id]} type="select" options={@users_opts} label="Users" />
        <.input field={@form[:plot_id]} type="hidden" value={@plot.id} />
        <:actions>
          <.button phx-disable-with="Saving...">Share</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{current_user: %{id: id}} = assigns, socket) do
    users_opts =
      StatsViewer.Accounts.list_user()
      |> Enum.reject(&(&1.id == id))
      |> Enum.map(&{&1.email, &1.id})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(users_opts: users_opts)
     |> assign_new(:form, fn ->
       to_form(Plots.change_plot_user(%PlotUser{}))
     end)}
  end

  @impl true
  def handle_event("validate", %{"plot_user" => params}, socket) do
    changeset = Plots.change_plot_user(%PlotUser{}, params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"plot_user" => params}, socket) do
    case Plots.create_plot_user(params) do
      {:ok, _plot_user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Plot Shared successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
