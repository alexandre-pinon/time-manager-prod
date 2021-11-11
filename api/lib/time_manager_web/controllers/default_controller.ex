defmodule TimeManagerAPIWeb.DefaultController do
  use TimeManagerAPIWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{message: "🧙 Ingress Chinoiseries: tkt ça marche 🧙"})
  end
end
