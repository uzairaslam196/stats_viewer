defmodule StatsViewer.Repo.Migrations.CreatePlots do
  use Ecto.Migration

  def change do
    create table(:plots) do
      add :name, :string, null: false
      add :dataset, :string, null: false
      add :expression, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:plots, [:dataset, :expression])
  end
end
