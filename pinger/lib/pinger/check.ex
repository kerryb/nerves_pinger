defmodule Pinger.Check do
  defstruct type: nil, address: nil

  @checks [
    dns: "google.com",
    dns: "github.com",
    http: "https://github.com",
    http: "https://bt.com",
    dns: "apple.com",
    dns: "guardian.com"
  ]

  def all do
    @checks |> Enum.map(fn {type, address} -> %__MODULE__{type: type, address: address} end)
  end

  def run(%__MODULE__{type: :dns, address: address}), do: Pinger.time_dns(address)
  def run(%__MODULE__{type: :http, address: address}), do: Pinger.time_http(address)
end
