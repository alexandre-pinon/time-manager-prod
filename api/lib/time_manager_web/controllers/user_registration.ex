defmodule TimeManagerAPIWeb.UserRegistration do
  use TimeManagerAPIWeb, :controller

  alias Ecto.Changeset
  alias TimeManagerAPIWeb.ErrorHelpers

  def sign_up(conn, %{"user" => user_registration_command}) do
    with {:ok, _user, conn} <- conn |> Pow.Plug.create_user(user_registration_command) do
      json(conn, %{
        data: %{
          id: conn.private.user_id,
          role: conn.private.role,
          token: conn.private.api_access_token
        }
      })
    else
      {:error, changeset, conn} ->
        errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)

        conn
        |> put_status(:bad_request)
        |> json(%{errors: errors})
    end
  end
end
