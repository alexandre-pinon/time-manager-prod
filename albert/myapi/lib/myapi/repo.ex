defmodule Myapi.Repo do
  use Ecto.Repo,
    otp_app: :myapi,
    adapter: Ecto.Adapters.Postgres
end
