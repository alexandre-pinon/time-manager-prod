# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManagerAPI.Repo.insert!(%TimeManagerAPI.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Logger

alias TimeManagerAPI.{Repo, TimeManagerData}
alias TimeManagerAPI.TimeManagerData.User

Repo.delete_all(User)

TimeManagerData.create_user(%{
  first_name: "admin",
  last_name: "admin",
  role: "admin",
  email: "admin@gmail.com",
  password: "kappa123",
  password_confirmation: "kappa123"
})
