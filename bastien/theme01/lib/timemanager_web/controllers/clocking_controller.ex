defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  def index(conn, %{"userID" => userID}) do
    conn
    |> put_resp_content_type("application/json")
    |> put_status(200)
    |> json(%{userID: userID})
  end

  def update(conn, _params) do
    render(conn, "index.html")
  end
end
