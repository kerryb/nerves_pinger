defmodule UIWeb.ResultsLive do
  use Phoenix.LiveView

  def mount(_session, socket) do
    socket = assign(socket, results: UI.Results.all())

    if connected?(socket) do
      pid = self()
      UI.Results.subscribe(fn results -> send(pid, {:update, results}) end)
    end

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <table class="table table-striped">
      <thead>
        <th>Type</th>
        <th>Address</th>
        <th>At</th>
        <th>Status</th>
        <th>Time (ms)</th>
      </thead>
      <tbody id="results-table">
        <%= for {check, result} <- @results do %>
          <tr id="<%= check.type %>-<%= check.address %>">
            <td><%= check.type %></td>
            <td><%= check.address %></td>
            <td><%= result.timestamp %></td>
            <td><%= result.status %></td>
            <td><%= if result.status == "ok", do: trunc(result.time), else: "—" %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  def handle_info({:update, results}, socket) do
    {:noreply, update(socket, :results, fn _ -> results end)}
  end
end
