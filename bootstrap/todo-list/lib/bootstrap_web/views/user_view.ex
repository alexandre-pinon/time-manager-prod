defmodule TodolistWeb.UserView do
  use TodolistWeb, :view
  alias TodolistWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end
end
