defmodule StatsViewer.Plots.Plot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plots" do
    field :name, :string
    field :dataset, :string
    field :expression, :string

    belongs_to :user, StatsViewer.Accounts.User
    has_many :plot_users, StatsViewer.Plots.PlotUser
    # add user_id

    # plot_users

    # user_id
    # plot_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(plot, attrs) do
    plot
    |> cast(attrs, [:name, :dataset, :expression, :user_id])
    |> validate_required([:name, :dataset, :expression, :user_id])
  end
end
