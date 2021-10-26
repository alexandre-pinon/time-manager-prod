defmodule TimeManagerAPIWeb.Router do
  use TimeManagerAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerAPIWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]

    scope "/workingtimes" do
      resources "/", WorkingTimeController, only: [:show, :update, :delete]
      get "/users/:userID", WorkingTimeController, :index
      post "/:userID", WorkingTimeController, :create
    end

    scope "/clocks" do
      get "/:userID", ClockController, :index
      post "/:userID", ClockController, :update
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
