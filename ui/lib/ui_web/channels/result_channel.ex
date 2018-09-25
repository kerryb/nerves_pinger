defmodule UiWeb.ResultChannel do
  use Phoenix.Channel

  alias UiWeb.Endpoint

  def join("results", _message, socket) do
    {:ok, socket}
  end

  def new_result(check, {status, time}) do
    Endpoint.broadcast!("results", "new_result", %{
      type: check.type,
      address: check.address,
      status: status,
      time: trunc(time)
    })
  end
end
