defmodule Pinger.Controller do
  use GenServer

  alias Pinger.Check
  alias UiWeb.ResultChannel

  @interval :timer.seconds(10)

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    send(self(), :tick)
    {:ok, %{checks: Check.all(), results: %{}}}
  end

  def results do
    GenServer.call(__MODULE__, :results)
  end

  def handle_info(:tick, state) do
    new_state = run_next_check(state)
    Process.send_after(self(), :tick, @interval)
    {:noreply, new_state}
  end

  def handle_call(:results, _from, state) do
    {:reply, state.results, state}
  end

  defp run_next_check(%{checks: [check | _] = checks, results: results}) do
    result = Check.run(check)
    # ResultChannel.new_result(check, result)
    %{checks: move_head_to_back(checks), results: add_result(results, check, result)}
  end

  defp move_head_to_back(list) do
    [list |> hd | list |> tl |> Enum.reverse()] |> Enum.reverse()
  end

  defp add_result(results, check, result) do
    results |> Map.put(check, result)
  end
end
