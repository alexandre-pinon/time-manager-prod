defmodule TimeManager.TimeManager.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :naive_datetime, null: false
    field :start, :naive_datetime, null: false
    field :user, :id, null: false

    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user])
    |> validate_required([:start, :end, :user])
    |> foreign_key_constraint(:user)
  end
end
