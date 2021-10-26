defmodule TimeManager.WorkingTimeManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.WorkingTimeManager` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-10-25 10:59:00],
        start: ~N[2021-10-25 10:59:00]
      })
      |> TimeManager.WorkingTimeManager.create_working_time()

    working_time
  end
end
