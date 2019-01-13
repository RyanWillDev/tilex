defmodule Tilex.ChannelsListChannel do
  use Phoenix.Channel

  alias Tilex.{Channel, Channels}

  def join("channels_list", _message, socket) do
    {:ok, socket}
  end

  def handle_in("add", %{"name" => _, "twitter_hashtag" => _} = params, socket) do
    assigns =
      case Channels.new(params) do
        {:ok, %Channel{}} ->
          channels =
            Channels.all()
            |> Enum.map(&Map.from_struct/1)
            |> Enum.map(&Map.take(&1, [:name, :twitter_hashtag, :id]))

          %{channels: channels}

        _ ->
          %{error: "Unable to create channel"}
      end

    push(socket, "updated", assigns)

    {:noreply, socket}
  end
end
