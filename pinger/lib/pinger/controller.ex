defmodule Pinger.Controller do
  use GenServer

  alias Pinger.Check

  @interval :timer.seconds(10)

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    send(self(), :tick)
    {:ok, %{checks: Check.all()}}
  end

  def handle_info(:tick, state) do
    Process.send_after(self(), :tick, @interval)
    {:noreply, run_next_check(state)}
  end

  def handle_info(_, state), do: {:noreply, state}

  defp run_next_check(%{checks: [check | other_checks]}) do
    {status, time} = Check.run(check)

    HTTPotion.post(
      "http://192.168.2.1:4000/api/results",
      body:
        Poison.encode!(%{type: check.type, address: check.address, status: status, time: time}),
      headers: [{"Content-Type", "application/json"}]
    )

    %{checks: other_checks ++ [check]}
  end
end
