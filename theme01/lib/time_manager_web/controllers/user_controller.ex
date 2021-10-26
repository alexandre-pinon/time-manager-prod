defmodule TimeManagerAPIWeb.UserController do
  use TimeManagerAPIWeb, :controller

  alias TimeManagerAPI.TimeManagerData
  alias TimeManagerAPI.TimeManagerData.User

  action_fallback TimeManagerAPIWeb.FallbackController

  def index(conn, _params) do
    users = TimeManagerData.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"email" => email, "username" => username}) do
    with {:ok, %User{} = user} <- TimeManagerData.create_user(%{email: email, username: username}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = TimeManagerData.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = TimeManagerData.get_user!(id)

    with {:ok, %User{} = user} <- TimeManagerData.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = TimeManagerData.get_user!(id)

    with {:ok, %User{}} <- TimeManagerData.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
