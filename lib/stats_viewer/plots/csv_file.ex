defmodule StatsViewer.Plots.CSVFile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "csv_files" do
    field :path, :string
    field :name, :string
    field :headers, {:array, :string}

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(csv_file, attrs) do
    csv_file
    |> cast(attrs, [:name, :path, :headers])
    |> validate_required([:name, :path, :headers])
  end
end
