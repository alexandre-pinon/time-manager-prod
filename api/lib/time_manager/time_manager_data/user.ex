defmodule TimeManagerAPI.TimeManagerData.User do
  use Ecto.Schema
  import Ecto.Changeset

  use Pow.Ecto.Schema

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :role, Ecto.Enum, values: [:user, :manager, :admin], default: :user
    pow_user_fields()

    has_one :clock, TimeManagerAPI.TimeManagerData.Clock
    has_many :working_time, TimeManagerAPI.TimeManagerData.WorkingTime

    timestamps()
  end

  @doc false
  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_user_id_field_changeset(attrs)
    |> pow_password_changeset(attrs)
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end

  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:role])
    |> validate_required([:role])
    |> validate_inclusion(:role, [:user, :manager, :admin])
  end
end
