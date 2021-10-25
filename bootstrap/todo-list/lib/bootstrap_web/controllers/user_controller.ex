defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller

  alias Todolist.UserManager
  alias Todolist.User

  action_fallback(TodolistWeb.FallbackController)

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- UserManager.get_user!(id) do
      render(conn, "show.json", user: user)
    end
  end
end
