defmodule LedgerWeb.Router do
  use LedgerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LedgerWeb do
    pipe_through :api

    post "/send", QueueController, :send
  end
end
