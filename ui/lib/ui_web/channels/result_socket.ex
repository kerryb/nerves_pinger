defmodule UIWeb.ResultSocket do
  use Phoenix.Socket

  channel("results", UIWeb.ResultChannel)
  transport(:websocket, Phoenix.Transports.WebSocket, check_origin: false)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
