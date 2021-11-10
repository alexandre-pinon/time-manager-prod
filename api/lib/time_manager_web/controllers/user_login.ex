defmodule TimeManagerAPIWeb.UserLogin do
  use TimeManagerAPIWeb, :controller

  def sign_in(conn, %{"user" => user_pass_login}) do
    with {:ok, conn} <- conn |> Pow.Plug.authenticate_user(user_pass_login) do
      json(conn, %{
        data: %{
          id: conn.private.user_id,
          role: conn.private.role,
          token: conn.private.api_access_token
        }
      })
    else
      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{errors: %{user: ["Invalid email or password"]}})
    end
  end
end
