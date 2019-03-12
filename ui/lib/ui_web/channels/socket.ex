defmodule UIWeb.Socket do
  use Phoenix.Socket

  channel("results", UIWeb.ResultChannel)
  channel("info", UIWeb.InfoChannel)

  transport(:websocket, Phoenix.Transports.WebSocket, check_origin: false)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
