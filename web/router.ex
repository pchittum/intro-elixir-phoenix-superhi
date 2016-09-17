defmodule Slick.Router do
  use Slick.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Slick do
    pipe_through :browser # Use the default browser stack

    resources "/rooms", RoomController

    get "/", PageController, :index
  end

  scope "/api", Slick do
    pipe_through :api

    resources "/posts", PostController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Slick do
  #   pipe_through :api
  # end
end
