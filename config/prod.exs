import Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
#
# Finally, we also include the path to a manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.

config :tilex, TilexWeb.Endpoint,
  instrumenters: [Appsignal.Phoenix.Instrumenter],
  http: [port: {:system, "PORT"}, compress: true],
  url: [host: "til.ryanwilldev.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: "${SECRET_KEY_BASE}",
  server: true,
  static_url: [host: "til.ryanwilldev.com", scheme: "https", port: 443]

# Do not print debug messages in production
config :logger, level: :info

config :tilex, Tilex.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  pool_size: 1,
  ssl: true

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :tilex, TilexWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
config :tilex, TilexWeb.Endpoint, force_ssl: [rewrite_on: [:x_forwarded_proto]]

# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :tilex, TilexWeb.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately.

# if System.get_env("ENABLE_BASIC_AUTH") do
#   config :tilex, :basic_auth,
#     realm: "tilex",
#     username: System.get_env("BASIC_AUTH_USERNAME"),
#     password: System.get_env("BASIC_AUTH_PASSWORD")
# end

config :tilex, :page_size, 50
config :tilex, :ga_identifier, "${GA_IDENTIFIER}"

config :appsignal, :config, active: true

config :tilex, :page_size, 50
config :tilex, :request_tracking, "${REQUEST_TRACKING}"

config :extwitter, :oauth,
  consumer_key: "${twitter_consumer_key}",
  consumer_secret: "${twitter_consumer_secret}",
  access_token: "${twitter_access_token}",
  access_token_secret: "${twitter_access_token_secret}"

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "${GOOGLE_CLIENT_ID}",
  client_secret: "${GOOGLE_CLIENT_SECRET}"

config :tilex, :organization_name, "${ORGANIZATION_NAME}"
config :tilex, :canonical_domain, "${CANONICAL_DOMAIN}"
config :tilex, :default_twitter_handle, "${DEFAULT_TWITTER_HANDLE}"
config :tilex, :cors_origin, "${CORS_ORIGIN}"
config :tilex, :hosted_domain, "${HOSTED_DOMAIN}"
config :tilex, :guest_author_whitelist, "${GUEST_AUTHOR_WHITELIST}"
config :tilex, :date_display_tz, "${DATE_DISPLAY_TZ}"
