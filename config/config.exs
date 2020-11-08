# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :chat_vue, ChatVueWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "isaN6kiop559SEFTa/wPAc3sdZQSm26iYzDrrRIg+Mo9xrqeeUCK3H0VPw4xO1I+",
  render_errors: [view: ChatVueWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ChatVue.PubSub,
  live_view: [signing_salt: "F/ILIDHb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
