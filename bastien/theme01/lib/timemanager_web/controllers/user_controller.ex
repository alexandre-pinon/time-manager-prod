defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
