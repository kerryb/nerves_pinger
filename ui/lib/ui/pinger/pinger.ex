defmodule Pinger do
  @doc """
  Time a DNS query, returning the number of milliseconds it took.
  """
  def time_dns(host) do
    with {microseconds, {:ok, _}} <- :timer.tc(&dns_query/1, [String.to_charlist(host)]) do
      {:ok, microseconds / 1_000}
    else
      {_microseconds, resp} -> resp
    end
  end

  defp dns_query(host) do
    :inet_res.gethostbyname(host)
  end

  @doc """
  Time an HTTP request, returning the number of milliseconds it took.
  """
  def time_http(url) do
    with {microseconds, {:ok, _}} <- :timer.tc(&http_request/1, [url]) do
      {:ok, microseconds / 1_000}
    else
      {_microseconds, resp} -> resp
    end
  end

  defp http_request(url) do
    HTTPoison.get url
  end
end
