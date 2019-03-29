defmodule UIWeb.ResultController do
  use UIWeb, :controller

  def create(conn, params) do
    UI.Results.record_result(%{type: params["type"], address: params["address"]}, %{
      status: params["status"],
      time: params["time"],
      timestamp: params["timestamp"]
    })

    conn
    |> put_status(:created)
    |> json(%{})
  end
end
