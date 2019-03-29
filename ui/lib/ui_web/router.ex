defmodule UIWeb.Router do
  use UIWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(Phoenix.LiveView.Flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", UIWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/api", UIWeb do
    pipe_through(:api)
    post("/results", ResultController, :create)
    post("/flash", FlashController, :create)
    delete("/flash", FlashController, :delete)
  end
end
