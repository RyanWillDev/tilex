ExUnit.configure(exclude: [pending: true])
ExUnit.start()

{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, TilexWeb.Endpoint.url())
