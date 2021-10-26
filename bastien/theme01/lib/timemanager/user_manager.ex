defmodule TimeManager.UserManager do
  @moduledoc """
  The UserManager context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo

  alias TimeManager.TimeManager.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    case Repo.all(User) do
      [] -> {:error, :not_found}
      users -> {:ok, users}
    end
  end

  @doc """
  Returns the list of users with parameters.

  ## Examples

      iex> list_users(email, username)
      [%User{}, ...]

  """
  def list_users(email, username) do
    query =
      from(u in User,
        where: u.email == ^email and u.username == ^username
      )

    # Send the query to the repository
    case Repo.all(query) do
      [] -> {:error, :not_found}
      users -> {:ok, users}
    end
  end

  @doc """
  Gets a single user.

  Raises if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

  """
  def get_user!(id), do: raise("TODO")

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, ...}

  """
  def create_user(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, ...}

  """
  def update_user(%User{} = user, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, ...}

  """
  def delete_user(%User{} = user) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Todo{...}

  """
  def change_user(%User{} = user, _attrs \\ %{}) do
    raise "TODO"
  end
end
