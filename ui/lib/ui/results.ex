defmodule UI.Results do
  use Agent

  def start_link() do
    Agent.start_link(fn -> %{subscribers: [], results: %{}} end, name: __MODULE__)
  end

  def all do
    Agent.get(__MODULE__, & &1.results)
  end

  def record_result(check, result) do
    Agent.update(__MODULE__, &put_result(&1, check, result))
  end

  defp put_result(state, check, result) do
    results = state.results |> Map.put(check, result)
    notify(state.subscribers, results)
    %{state | results: results}
  end

  def subscribe(callback) do
    Agent.update(__MODULE__, &put_subscriber(&1, callback))
  end

  defp put_subscriber(%{subscribers: subscribers} = state, callback) do
    %{state | subscribers: [callback | subscribers]}
  end

  defp notify(subscribers, results) do
    subscribers |> Enum.each(& &1.(results))
  end
end
