defmodule UIWeb.InfoChannel do
  use Phoenix.Channel

  alias UIWeb.Endpoint

  def join("info", _message, socket) do
    {:ok, socket}
  end

  def set_message(params) do
    Endpoint.broadcast!("info", "message", params)
  end

  def clear_message do
    Endpoint.broadcast!("info", "clear", %{})
  end
end
