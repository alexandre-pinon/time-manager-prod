defmodule TimeManager.ClockManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.ClockManager` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2021-10-25 10:57:00]
      })
      |> TimeManager.ClockManager.create_clock()

    clock
  end
end
