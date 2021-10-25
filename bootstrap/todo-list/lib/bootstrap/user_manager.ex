defmodule Todolist.UserManager do
  @moduledoc """
  The UserManager context.
  """

  import Ecto.Query, warn: false
  alias Todolist.Repo

  alias Todolist.User

  @doc """
  Gets a single user.

  Raises if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

  """
  def get_user!(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
