defmodule TimeManagerAPIWeb.TeamController do
  use TimeManagerAPIWeb, :controller

  alias TimeManagerAPI.TimeManagerData
  alias TimeManagerAPI.TimeManagerData.Team

  plug TimeManagerAPIWeb.EnsureRolePlug,
       [roles: ["admin", "manager"], check_self: true] when action in [:create, :update, :delete]

  action_fallback TimeManagerAPIWeb.FallbackController

  def index(conn, _params) do
    teams = TimeManagerData.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- TimeManagerData.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = TimeManagerData.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = TimeManagerData.get_team!(id)

    with {:ok, %Team{} = team} <- TimeManagerData.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = TimeManagerData.get_team!(id)

    with {:ok, %Team{}} <- TimeManagerData.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
