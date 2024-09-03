defmodule StatsViewer.Repo.Migrations.CreatePlotsUsers do
  use Ecto.Migration

  def change do
    create table(:plot_users) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :plot_id, references(:plots, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
