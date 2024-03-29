defmodule TimeManagerAPIWeb.TeamView do
  use TimeManagerAPIWeb, :view
  alias TimeManagerAPIWeb.TeamView
  alias TimeManagerAPIWeb.UserView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name,
      users: render_many(team.users, UserView, "team.user.json", as: :user)
    }
  end
  def render("user.team.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name,
    }
  end
end
