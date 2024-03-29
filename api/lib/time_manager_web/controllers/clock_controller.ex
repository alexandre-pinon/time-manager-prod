defmodule TimeManagerAPIWeb.ClockController do
  use TimeManagerAPIWeb, :controller

  alias TimeManagerAPI.TimeManagerData
  alias TimeManagerAPI.TimeManagerData.Clock

  plug TimeManagerAPIWeb.EnsureRolePlug,
       [roles: "admin", check_self: true] when action in [:create, :update]

  action_fallback TimeManagerAPIWeb.FallbackController

  def index(conn, _params) do
    clocks = TimeManagerData.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def show(conn, %{"userID" => userID}) do
    clock = TimeManagerData.get_clock!(userID)
    render(conn, "show.json", clock: clock)
  end

  def create(conn, %{"clock" => clock_params, "userID" => userID}) do
    clock_params = Map.put(clock_params, "user_id", userID)

    with {:ok, %Clock{} = clock} <- TimeManagerData.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def update(conn, %{"userID" => userID, "clock" => clock_params}) do
    clock = TimeManagerData.get_clock!(userID)

    with {:ok, %Clock{} = clock} <- TimeManagerData.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = TimeManagerData.get_clock!(id)

    with {:ok, %Clock{}} <- TimeManagerData.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
