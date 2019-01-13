defmodule TilexWeb.ChannelController do
  use TilexWeb, :controller

  alias Tilex.{Channels, Posts}

  def show(conn, %{"name" => channel_name} = params) do
    page =
      params
      |> Map.get("page", "1")
      |> String.to_integer()

    {posts, posts_count, channel} = Posts.by_channel(channel_name, page)

    render(
      conn,
      "show.html",
      posts: posts,
      posts_count: posts_count,
      channel: channel,
      page: page
    )
  end

  def edit(conn, _params) do
    channels = Channels.all()
    render(conn, "edit.html", channels: channels)
  end
end
