import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :time_manager, TimeManagerAPI.Repo,
  username: "postgres",
  password: "postgres",
  database: "time_manager_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  port: "5435",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :time_manager, TimeManagerAPIWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "AaAap2FzJvdvmRn6pczjgy8B7OaLnSrCfsDseDw1TDIPwTQmSmcQgsJNmoiu4rzf",
  server: false

# In test we don't send emails.
config :time_manager, TimeManagerAPI.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
