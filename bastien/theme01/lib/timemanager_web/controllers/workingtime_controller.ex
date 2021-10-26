defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
  # def show(conn, %{"id" => id}) do
  #   conn
  #   |> put_resp_content_type("application/json")
  #   |> put_status(200)
  #   |> json(%{userID: userID})
  # end
end
