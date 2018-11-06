defmodule UI.Results do
  use Agent

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def all do
    Agent.get(__MODULE__, & &1)
  end

  def record_result(check, result) do
    Agent.update(__MODULE__, &(&1 |> Map.put(check, result)))
  end
end
