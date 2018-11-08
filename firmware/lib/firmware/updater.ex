defmodule Firmware.Updater do
  use GenServer

  @interval :timer.seconds(10)
  @firmware_url "http://192.168.2.1:4000/firmware.fw"
  @firmware_file "/root/firmware.fw"

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    send(self(), :tick)
    {:ok, %{etag: nil}}
  end

  def handle_info(:tick, state) do
    {:noreply, check_for_new_firmware(state)}
  end

  def handle_info(_, state), do: {:noreply, state}

  defp check_for_new_firmware(%{etag: old_etag}) do
    response = HTTPotion.head(@firmware_url)
    new_etag = response.headers[:etag]

    if should_update?(old_etag, new_etag) do
      download_firmware()
      update_and_reboot()
    else
      Process.send_after(self(), :tick, @interval)
    end

    %{etag: new_etag}
  end

  def should_update?(nil = _old_etag, _new_etag) do
    !File.exists?(@firmware_file)
  end

  def should_update?(old_etag, new_etag) do
    old_etag != new_etag
  end

  def download_firmware do
    HTTPotion.get(@firmware_url, stream_to: self(), timeout: :timer.minutes(5))
    receive_data()
  end

  defp receive_data(file \\ File.open!(@firmware_file, [:write])) do
    receive do
      %HTTPotion.AsyncHeaders{} ->
        IO.puts("Received headers")
        receive_data(file)

      %HTTPotion.AsyncChunk{chunk: chunk} ->
        IO.puts("Received chunk")
        IO.binwrite(file, chunk)
        receive_data(file)

      %HTTPotion.AsyncEnd{} ->
        IO.puts("complete")
        File.close(file)
    end
  end

  def update_and_reboot do
    Nerves.Firmware.apply(@firmware_file, "complete")
    Nerves.Firmware.reboot()
  end
end
