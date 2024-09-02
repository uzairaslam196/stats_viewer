defmodule StatsViewer.Repo.Migrations.AddCsvFileTable do
  use Ecto.Migration

  def change do
    create table(:csv_files) do
      add :path, :string
      add :name, :string, null: false
      add :headers, {:array, :string}, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:csv_files, [:path, :name])
  end
end
