defmodule Todolist.TaskManager do
  @moduledoc """
  The TaskManager context.
  """

  import Ecto.Query, warn: false
  alias Todolist.Repo

  alias Todolist.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Gets a single task.

  Raises if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

  """
  def get_task!(id) do
    case Repo.get(Task, id) do
     nil -> {:error, :not_found}
     task -> {:ok, task}
    end
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, ...}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, ...}

  """
  def update_task(%Task{} = _task, _attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, ...}

  """
  def delete_task(%Task{} = _task) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Todo{...}

  """
  def change_task(%Task{} = _task, _attrs \\ %{}) do
    raise "TODO"
  end
end
