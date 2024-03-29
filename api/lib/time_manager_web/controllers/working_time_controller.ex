defmodule TimeManagerAPIWeb.WorkingTimeController do
  use TimeManagerAPIWeb, :controller

  alias TimeManagerAPI.TimeManagerData
  alias TimeManagerAPI.TimeManagerData.WorkingTime

  plug TimeManagerAPIWeb.EnsureRolePlug,
       [roles: "admin"] when action in [:update, :delete]

  action_fallback TimeManagerAPIWeb.FallbackController

  def index(conn, %{"userID" => userID, "start" => start, "end" => endd}) do
    workingtimes = TimeManagerData.list_workingtimes!(userID, start, endd)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def index(conn, %{"userID" => userID, "start" => start}) do
    workingtimes = TimeManagerData.list_workingtimes_by_start(userID, start)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def index(conn, %{"userID" => userID, "end" => endd}) do
    workingtimes = TimeManagerData.list_workingtimes_by_end(userID, endd)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def index(conn, %{"userID" => userID}) do
    workingtimes = TimeManagerData.list_workingtimes!(userID)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def index(conn, _params) do
    workingtimes = TimeManagerData.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def show(conn, %{"userID" => userID, "id" => id}) do
    working_time = TimeManagerData.get_working_time!(userID, id)
    render(conn, "show.json", working_time: working_time)
  end

  def create(conn, %{"working_time" => working_time_params, "userID" => userID}) do
    working_time_params = Map.put(working_time_params, "user_id", userID)

    with {:ok, %WorkingTime{} = working_time} <-
           TimeManagerData.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.working_time_path(conn, :show, userID, working_time)
      )
      |> render("show.json", working_time: working_time)
    end
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = TimeManagerData.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <-
           TimeManagerData.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = TimeManagerData.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- TimeManagerData.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
