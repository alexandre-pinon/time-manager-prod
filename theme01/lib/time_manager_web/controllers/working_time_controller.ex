defmodule TimeManagerAPIWeb.WorkingTimeController do
  use TimeManagerAPIWeb, :controller

  alias TimeManagerAPI.TimeManagerData
  alias TimeManagerAPI.TimeManagerData.WorkingTime

  action_fallback TimeManagerAPIWeb.FallbackController

  def index(conn, _params) do
    workingtimes = TimeManagerData.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userID" => userID, "start" => start, "end" => endd}) do
    working_time_params = %{"user_id" => userID, "start" => start, "end" => endd}
    with {:ok, %WorkingTime{} = working_time} <- TimeManagerData.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, %{"id" => id}) do
    working_time = TimeManagerData.get_working_time!(id)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = TimeManagerData.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- TimeManagerData.update_working_time(working_time, working_time_params) do
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
