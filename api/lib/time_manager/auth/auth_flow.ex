defmodule TimeManagerAPI.Auth.AuthFlow do
  use Pow.Plug.Base

  require Logger

  alias Plug.Conn
  alias TimeManagerAPI.Auth.Token

  def fetch(conn, _config) do
    with {:ok, jwt_token} <- read_token(conn),
         {:ok, claims} <- validate_token(jwt_token) do
      conn =
        conn
        |> Conn.put_private(:api_access_token, jwt_token)
        |> Conn.put_private(:user_id, claims["user_id"])
        |> Conn.put_private(:role, claims["role"])

      {conn, %{"token" => jwt_token}}
    else
      _any -> {conn, nil}
    end
  end

  def create(conn, user, _config) do
    claims = %{"user_id" => user.id, "role" => user.role}
    generated_token = Token.generate_and_sign!(claims)

    conn =
      conn
      |> Conn.put_private(:api_access_token, generated_token)
      |> Conn.put_private(:user_id, claims["user_id"])
      |> Conn.put_private(:role, claims["role"])

    {conn, user}
  end

  def delete(conn, _config) do
    conn
  end

  defp read_token(conn) do
    case Conn.get_req_header(conn, "authorization") do
      [token | _rest] -> {:ok, token |> String.replace("Bearer", "") |> String.trim()}
      _any -> {:error, "No Auth token found"}
    end
  end

  defp validate_token(jwt_token),
    do: Token.verify_and_validate(jwt_token)
end
