defmodule UIWeb.PageController do
  use UIWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:results, [])
    |> assign(:results, UI.Results.all())
    |> render("index.html")
  end
end
