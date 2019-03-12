defmodule UIWeb.FlashController do
  use UIWeb, :controller

  def create(conn, params) do
    UIWeb.InfoChannel.set_message(params)
    conn |> put_status(:created) |> json(%{})
  end

  def delete(conn, _params) do
    UIWeb.InfoChannel.clear_message()
    conn |> put_status(:ok) |> json(%{})
  end
end
