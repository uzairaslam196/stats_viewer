defmodule StatsViewer.Plots.Plot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plots" do
    field :name, :string
    field :dataset, :string
    field :expression, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(plot, attrs) do
    plot
    |> cast(attrs, [:name, :dataset, :expression])
    |> validate_required([:name, :dataset, :expression])
  end
end
