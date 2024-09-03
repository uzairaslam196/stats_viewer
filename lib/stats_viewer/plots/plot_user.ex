defmodule StatsViewer.Plots.PlotUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plot_users" do
    belongs_to :user, StatsViewer.Accounts.User
    belongs_to :plot, StatsViewer.Plots.Plot

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(plot, attrs) do
    plot
    |> cast(attrs, [:user_id, :plot_id])
    |> validate_required([:user_id, :plot_id])
    |> unsafe_validate_unique([:user_id, :plot_id], StatsViewer.Repo)
  end
end
