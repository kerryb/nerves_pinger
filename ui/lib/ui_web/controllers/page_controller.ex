defmodule UIWeb.PageController do
  use UIWeb, :controller

  def index(conn, _params) do
    Phoenix.LiveView.Controller.live_render(conn, UIWeb.ResultsLive, session: %{})
  end
end
