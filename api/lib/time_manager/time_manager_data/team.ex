defmodule TimeManagerAPI.TimeManagerData.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string

    many_to_many :users, TimeManagerAPI.TimeManagerData.User, join_through: "teams_users", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :users])
    |> validate_required([:name, :users])
  end
end
