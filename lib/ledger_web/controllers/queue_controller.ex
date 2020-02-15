defmodule LedgerWeb.QueueController do
  use LedgerWeb, :controller

  alias Ledger.Queue.Publisher

  def send(conn, params) do
    {:ok, message} = Poison.encode(params)
    Publisher.publish(message)

    conn
    |> text("200")
  end
end
