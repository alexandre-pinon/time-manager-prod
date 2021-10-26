defmodule Myapi.Myapi.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task" do
    field :description_name, :string
    field :status, :string
    field :title, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :status, :description_name, :user])
    |> validate_required([:title, :status, :description_name, :user])
  end
end
