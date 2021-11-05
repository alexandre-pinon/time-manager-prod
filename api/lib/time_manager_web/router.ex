defmodule TimeManagerAPIWeb.Router do
  use TimeManagerAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug TimeManagerAPI.Auth.AuthFlow, otp_app: :time_manager
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/api", TimeManagerAPIWeb do
    pipe_through :api

    scope "/users" do
      resources "/", UserController, except: [:new, :edit]
      post "/sign_in", UserLogin, :sign_in
      post "/sign_up", UserRegistration, :sign_up
    end

    scope "/workingtimes" do
      resources "/", WorkingTimeController, only: [:update, :delete]
      resources "/:userID", WorkingTimeController, only: [:show, :index, :create]
    end

    scope "/clocks" do
      get "/:userID", ClockController, :show
      post "/:userID", ClockController, :create
      put "/:userID", ClockController, :update
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
