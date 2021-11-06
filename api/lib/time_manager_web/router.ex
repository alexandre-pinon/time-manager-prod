defmodule TimeManagerAPIWeb.Router do
  use TimeManagerAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug TimeManagerAPI.Auth.AuthFlow, otp_app: :time_manager
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: TimeManagerAPIWeb.AuthErrorHandler
  end

  scope "/api", TimeManagerAPIWeb do
    pipe_through :api

    scope "/users" do
      post "/sign_in", UserLogin, :sign_in
      post "/sign_up", UserRegistration, :sign_up
    end

    pipe_through :api_protected

    scope "/users" do
      resources "/", UserController, except: [:new, :edit]
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
end
