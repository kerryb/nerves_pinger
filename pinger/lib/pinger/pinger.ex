defmodule Pinger do
  @doc """
  Time a DNS query, returning the number of milliseconds it took.
  """
  def time_dns(host) do
    time(&dns_query/1, [String.to_charlist(host)])
  end

  @doc """
  Time an HTTP request, returning the number of milliseconds it took.
  """
  def time_http(url) do
    time(&http_request/1, [url])
  end

  defp time(function, args) do
    with {microseconds, {:ok, _}} <- :timer.tc(function, args) do
      {:ok, microseconds / 1_000}
    else
      {_microseconds, resp} -> resp
    end
  end

  defp dns_query(host) do
    :inet_res.getbyname(host, :a)
  end

  defp http_request(url) do
    with %{status_code: status} <- HTTPotion.get(url) do
      if status < 400 do
        {:ok, status}
      else
        {:error, status}
      end
    else
      %HTTPotion.ErrorResponse{message: message} -> {:error, message}
    end
  end
end
