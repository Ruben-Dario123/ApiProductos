import Config

config :hola_api,
  ecto_repos: [HolaApi.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configure the endpoint
config :hola_api, HolaApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: HolaApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: HolaApi.PubSub,
  live_view: [signing_salt: "BSN/u3ve"]

# Configure the mailer
config :hola_api, HolaApi.Mailer, adapter: Swoosh.Adapters.Local

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# --- CONFIGURACIÓN DE GUARDIAN (UBICACIÓN CORRECTA) ---
config :hola_api, HolaApi.Guardian,
  issuer: "hola_api",
  secret_key: "UNA_CLAVE_MUY_SECRETA_Y_LARGA_QUE_TU_INVENTES_AQUI",
  module: HolaApi.Guardian,
  token_ttl: %{"access" => {30, :minutes}}

# IMPORTANTE: Esta línea SIEMPRE va al final
import_config "#{config_env()}.exs"
