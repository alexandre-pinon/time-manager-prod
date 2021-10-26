defmodule Myapi.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:task) do
      add :users, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:task, [:users])
  end
end
