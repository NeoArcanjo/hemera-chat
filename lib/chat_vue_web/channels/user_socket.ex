defmodule ChatVueWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "chat_people:*",  ChatVueWeb.ChatPeopleChannel
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil

end
