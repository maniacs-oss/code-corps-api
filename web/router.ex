defmodule CodeCorps.Router do
  use CodeCorps.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/", CodeCorps do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", CodeCorps, host: "api." do
    pipe_through :api

    resources "/categories", CategoryController, except: [:delete]
    resources "/organizations", OrganizationController, except: [:new, :edit]

    get "/users/email_available", UserController, :email_available
    get "/users/username_available", UserController, :username_available
    resources "/users", UserController, except: [:new, :edit]

    get "/:slug", SluggedRouteController, :show
  end
end