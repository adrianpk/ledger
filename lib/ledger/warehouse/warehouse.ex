defmodule Ledger.Warehouse do
  @moduledoc """
  The Warehouse context.
  """

  import Ecto.Query, warn: false
  alias Ledger.Repo

  alias Ledger.Warehouse.TrackingStatus

  alias Ledger.Warehouse.Commands.{
    ReceiveFromTransport,
    ClassifyItem
  }

  alias Ledger.Warehouse.Projections.TrackingStatus
  alias Ledger.App
  alias Ledger.Repo

  @doc """
  Receive from transport.
  """
  def receive_from_transport(attrs \\ %{}) do
    uuid = UUID.uuid4()

    receive_from_transport =
      attrs
      |> ReceiveFromTransport.new()
      |> ReceiveFromTransport.assign_uuid(uuid)

    with :ok <- App.dispatch(receive_from_transport, consistency: :strong) do
      get(TrackingStatus, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Classify item.
  """
  def classify_item(attrs \\ %{}) do
    classify_item =
      attrs
      |> ClassifyItem.new()

    with :ok <- App.dispatch(classify_item, consistency: :strong) do
      get(TrackingStatus, attrs[:tracking_uuid])
    else
      reply -> reply
    end
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
