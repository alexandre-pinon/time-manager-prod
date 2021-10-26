defmodule TimeManager.UserManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.UserManager` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManager.UserManager.create_user()

    user
  end
end