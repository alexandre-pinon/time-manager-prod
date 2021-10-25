defmodule Todolist.TaskManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.TaskManager` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{

      })
      |> Todolist.TaskManager.create_task()

    task
  end
end
