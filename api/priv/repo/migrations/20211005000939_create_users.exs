defmodule TimeManagerAPI.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :role, :string, null: false, default: "user"
      add :email, :string, null: false
      add :password_hash, :string, null: false, redact: true

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
