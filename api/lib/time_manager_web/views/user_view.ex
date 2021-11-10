defmodule TimeManagerAPIWeb.UserView do
  use TimeManagerAPIWeb, :view
  alias TimeManagerAPIWeb.TeamView
  alias TimeManagerAPIWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      role: user.role,
      email: user.email,
      teams: render_many(user.teams, TeamView, "user.team.json", as: :team)
    }
  end

  def render("team.user.json", %{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      role: user.role,
      email: user.email
    }
  end
end
