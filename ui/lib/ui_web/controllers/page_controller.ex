defmodule UiWeb.PageController do
  use UiWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:results, [])
    |> assign(:results, Ui.Results.all())
    |> render("index.html")
  end
end
