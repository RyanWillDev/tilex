import Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :tilex, TilexWeb.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :tilex, TilexWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/tilex_web/views/.*(ex)$},
      ~r{lib/tilex_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :tilex, Tilex.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  database: "tilryanwilldev",
  hostname: "localhost",
  pool_size: 10

config :tilex, :page_size, 50
config :tilex, :cors_origin, "http://localhost:3000"
config :tilex, :default_twitter_handle, System.get_env("DEFAULT_TWITTER_HANDLE")

config :tilex, :request_tracking, true

config :extwitter, :oauth,
  consumer_key: System.get_env("twitter_consumer_key"),
  consumer_secret: System.get_env("twitter_consumer_secret"),
  access_token: System.get_env("twitter_access_token"),
  access_token_secret: System.get_env("twitter_access_token_secret")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :tilex, :organization_name, System.get_env("ORGANIZATION_NAME")
config :tilex, :canonical_domain, System.get_env("CANONICAL_DOMAIN")
config :tilex, :default_twitter_handle, System.get_env("DEFAULT_TWITTER_HANDLE")
config :tilex, :cors_origin, System.get_env("CORS_ORIGIN")
config :tilex, :hosted_domain, System.get_env("HOSTED_DOMAIN")
config :tilex, :guest_author_whitelist, ("GUEST_AUTHOR_WHITELIST")
config :tilex, :date_display_tz, System.get_env("DATE_DISPLAY_TZ")
