defmodule AccountingSystemWeb.Router do
  use AccountingSystemWeb, :router
  # import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AccountingSystemWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/accounts", AccountController
    live "/example", ExampleLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", AccountingSystemWeb do
  #   pipe_through :api
  # end
end
