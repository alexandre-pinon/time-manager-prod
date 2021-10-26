defmodule TodolistWeb.TaskController do
  use TodolistWeb, :controller

  alias Todolist.TaskManager
  alias Todolist.Task

  action_fallback(TodolistWeb.FallbackController)

  def index(conn, _params) do
    tasks = TaskManager.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- TaskManager.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Task{} = task} <- TaskManager.get_task!(id) do
      render(conn, "show.json", task: task)
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = TaskManager.get_task!(id)

    with {:ok, %Task{} = task} <- TaskManager.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = TaskManager.get_task!(id)

    with {:ok, %Task{}} <- TaskManager.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end