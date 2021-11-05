defmodule TimeManagerAPI.TimeManagerData.User do
  use Ecto.Schema
  import Ecto.Changeset

  use Pow.Ecto.Schema

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    pow_user_fields()

    has_one :clock, TimeManagerAPI.TimeManagerData.Clock
    has_many :working_time, TimeManagerAPI.TimeManagerData.WorkingTime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
