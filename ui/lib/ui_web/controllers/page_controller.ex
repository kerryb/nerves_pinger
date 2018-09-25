defmodule UiWeb.PageController do
  use UiWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:results, Pinger.Controller.results)
    |> render("index.html")
  end
end
