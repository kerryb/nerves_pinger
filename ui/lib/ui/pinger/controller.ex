defmodule Pinger.Controller do
  use GenServer

  alias Pinger.Check

  @interval :timer.seconds(10)

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    send(self(), :tick)
    {:ok, %{checks: Check.all(), results: []}}
  end

  def handle_info(:tick, state) do
    checks = run_next_check(state.checks)
    Process.send_after(self(), :tick, @interval)
    {:noreply, %{state | checks: checks}}
  end

  defp run_next_check([check | _] = checks) do
    check |> Check.run() |> IO.inspect()
    move_head_to_back(checks)
  end

  defp move_head_to_back(list) do
    [list |> hd | list |> tl |> Enum.reverse()] |> Enum.reverse()
  end
end
