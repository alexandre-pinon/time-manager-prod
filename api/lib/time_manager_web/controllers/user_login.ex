defmodule TimeManagerAPIWeb.UserLogin do
  use TimeManagerAPIWeb, :controller

  alias Plug.Conn
  alias TimeManagerAPI.Auth.UserPassLogin

  def sign_in(conn, %{"user" => user_pass_login}) do
    with {:ok, conn} <- conn |> Pow.Plug.authenticate_user(user_pass_login) do
      json(conn, %{token: conn.private[:api_access_token]})
    else
      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid email or password"}})
    end
  end
end
