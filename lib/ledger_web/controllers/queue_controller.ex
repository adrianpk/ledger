defmodule LedgerWeb.QueueController do
  use LedgerWeb, :controller

  alias Ledger.Queue.Worker

  def index(conn, params) do
    {:ok, message} = Poison.encode(params)
    Worker.publish(message)

    conn
    |> text("200")
  end
end
