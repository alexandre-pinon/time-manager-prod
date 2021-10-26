defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller
  require Logger

  alias TimeManager.UserManager
  alias TimeManager.TimeManager.User

  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, %{"email" => email, "username" => username}) do
    with {:ok, [%User{}] = users} <- UserManager.list_users(email, username) do
      conn
      |> put_resp_content_type("application/json")
      |> put_status(200)
      |> json(%{"users" => users})
    end
  end

  def index(conn, _params) do
    with {:ok, [%User{}] = users} <- UserManager.list_users() do
      conn
      |> put_resp_content_type("application/json")
      |> put_status(200)
      |> json(%{"users" => users})
    end
  end
end
