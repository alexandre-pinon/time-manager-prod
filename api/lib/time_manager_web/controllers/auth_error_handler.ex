defmodule TimeManagerAPIWeb.AuthErrorHandler do
    use TimeManagerAPIWeb, :controller

  def call(conn, :not_authenticated) do
    conn
    |> put_status(401)
    |> json(%{error: %{code: 401, message: "Unauthorized 😕"}})
  end
end
