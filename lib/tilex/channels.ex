defmodule Tilex.Channels do
  alias Tilex.{Channel, Repo}

  def all() do
    Channel
    |> Repo.all()
  end

  def new(channel_params) do
    Channel.changeset(%Channel{}, channel_params)
    |> Repo.insert()
  end
end
