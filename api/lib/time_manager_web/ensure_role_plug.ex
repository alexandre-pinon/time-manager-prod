defmodule TimeManagerAPIWeb.EnsureRolePlug do
  @moduledoc """
  This plug ensures that a user has a particular role.

  ## Example

      plug TimeManagerAPIWeb.EnsureRolePlug, [:user, :admin]

      plug TimeManagerAPIWeb.EnsureRolePlug, :admin

      plug TimeManagerAPIWeb.EnsureRolePlug, ~w(user admin)a
  """
  import Plug.Conn, only: [halt: 1]

  alias Phoenix.Controller
  alias Plug.Conn

  @doc false
  def init(config) do
    roles = Keyword.get(config, :roles)
    check_self = Keyword.get(config, :check_self, false)
    %{roles: roles, check_self: check_self}
  end

  @doc false
  def call(conn, config) do
    conn.private
    |> has_role?(config.roles)
    |> case do
      has_role when config.check_self -> is_self?(has_role, conn.private, conn.params)
      has_role -> has_role
    end
    |> maybe_halt(conn)
  end

  defp has_role?(nil, _roles), do: false

  defp has_role?(user_role, roles) when is_list(roles),
    do: Enum.any?(roles, &has_role?(user_role, &1))

  defp has_role?(user_role, role) when is_atom(role),
    do: has_role?(user_role, Atom.to_string(role))

  defp has_role?(%{role: role}, role), do: true
  defp has_role?(_user, _role), do: false

  defp is_self?(true, _private, _params), do: true
  defp is_self?(_any, %{user_id: user_id}, %{"id" => id}), do: Integer.to_string(user_id) === id

  defp is_self?(_any, %{user_id: user_id}, %{"userID" => userID}),
    do: Integer.to_string(user_id) === userID # For Clock routes

  defp is_self?(_any, _private, _params), do: false

  defp maybe_halt(true, conn), do: conn

  defp maybe_halt(_any, conn) do
    conn
    |> Conn.put_status(403)
    |> Controller.json(%{error: %{code: 403, message: "Forbidden 😠"}})
    |> halt()
  end
end
