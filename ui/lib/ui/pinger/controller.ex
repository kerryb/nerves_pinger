defmodule Pinger.Controller do
  use GenServer

  alias Pinger.Check

  @interval :timer.seconds(2)

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    send(self(), :tick)
    {:ok, %{checks: Check.all(), results: %{}}}
  end

  def handle_info(:tick, state) do
    new_state = run_next_check(state) |> IO.inspect()
    Process.send_after(self(), :tick, @interval)
    {:noreply, new_state}
  end

  defp run_next_check(%{checks: [check | _] = checks, results: results}) do
    result = Check.run(check)
    %{checks: move_head_to_back(checks), results: add_result(results, check, result)}
  end

  defp move_head_to_back(list) do
    [list |> hd | list |> tl |> Enum.reverse()] |> Enum.reverse()
  end

  defp add_result(results, check, result) do
    results |> Map.put(check, result)
  end
end
