defmodule Myapi.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:task) do
      add :title, :string
      add :status, :string
      add :description_name, :string
      add :user, :string

      timestamps()
    end
  end
end
