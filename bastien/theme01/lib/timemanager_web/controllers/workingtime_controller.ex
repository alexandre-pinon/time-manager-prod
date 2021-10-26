defmodule TimeManagerWeb.WorkingTimeController do

  use TimeManagerWeb, :controller

  def index(conn, %{"userID" => userID, "start" => start, "end" => endtime}) do
    # render(conn, "index.html")
    #conn
    # |> put_resp_content_type("application/json")
    # |> put_status(200)
    # |> json(%{userID: userID})
    case Timemanager.create_clock(conn.assign.current_user, "userID" => userID, "start" => start, "end" => endtime) do
      {:ok, clock} ->
        conn
        |> put_status(:created)
        |> render("show.json", clock)
      {:error, changeset()} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset)
    end
  end
end
