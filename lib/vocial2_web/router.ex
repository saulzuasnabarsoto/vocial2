defmodule Vocial2Web.Router do
  use Vocial2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Vocial2Web.VerifyApiKey
  end

  scope "/", Vocial2Web do
    pipe_through :browser

    get "/", PageController, :index

    resources "/sessions", SessionController, only: [:create]

    get "/login", SessionController, :new
    get "/logout", SessionController, :delete

    resources "/polls", PollController, only: [:index, :new, :create, :show]
    get "/options/:id/vote", PollController, :vote

    resources "/users", UserController, only: [:new, :show, :create]
    post "/users/:id/generate_api_key", UserController, :generate_api_key

    get "/history", PageController, :history
  end

  # Other scopes may use custom stacks.
  scope "/api", Vocial2Web do
    pipe_through :api

    resources "/polls", Api.PollController, only: [:index, :show]
  end
end
