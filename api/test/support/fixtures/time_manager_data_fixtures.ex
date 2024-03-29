defmodule TimeManagerAPI.TimeManagerDataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerAPI.TimeManagerData` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> TimeManagerAPI.TimeManagerData.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2021-10-25 12:00:00]
      })
      |> TimeManagerAPI.TimeManagerData.create_clock()

    clock
  end

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-10-25 12:02:00],
        start: ~N[2021-10-25 12:02:00]
      })
      |> TimeManagerAPI.TimeManagerData.create_working_time()

    working_time
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name",
        users: []
      })
      |> TimeManagerAPI.TimeManagerData.create_team()

    team
  end
end
