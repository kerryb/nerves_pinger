defmodule UiWeb.ResultChannel do
  use Phoenix.Channel

  alias UiWeb.Endpoint

  def join("results", _message, socket) do
    {:ok, socket}
  end

  def new_result(check, result) do
    Endpoint.broadcast!("results", "new_result", %{
      type: check.type,
      address: check.address,
      status: result.status,
      time: time_if_ok(result)
    })
  end

  defp time_if_ok(%{status: :ok, time: time}), do: trunc(time)
  defp time_if_ok(_, _), do: "—"
end
