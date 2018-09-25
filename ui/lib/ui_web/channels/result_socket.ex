defmodule UiWeb.ResultSocket do
  use Phoenix.Socket

  channel("results", UiWeb.ResultChannel)
  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
