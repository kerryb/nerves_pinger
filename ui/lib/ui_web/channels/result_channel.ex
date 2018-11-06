defmodule UIWeb.ResultChannel do
  use Phoenix.Channel

  alias UIWeb.Endpoint

  def join("results", _message, socket) do
    {:ok, socket}
  end

  def new_result(params) do
    Endpoint.broadcast!("results", "new_result", params)
  end
end
