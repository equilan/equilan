defmodule EquilanWeb.Router do
  use EquilanWeb, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/api", EquilanWeb do
    pipe_through :api

    resources "/session", SessionController, only: [:index]
    resources "/user", UserController, only: [:index, :show]
  end
end
