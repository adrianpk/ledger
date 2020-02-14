defmodule Ledger.Warehouse do
  @moduledoc """
  The Warehouse context.
  """

  import Ecto.Query, warn: false
  alias Ledger.Repo

  alias Ledger.Warehouse.TrackingStatus

  alias Ledger.Warehouse.Commands.{
    ReceiveFromTransport,
    ClassifyItem,
    RelocateInStore,
    RequestShipping,
    DispatchForShipping
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

  @doc """
  RelocateInStore.
  """
  def relocate_in_store(attrs \\ %{}) do
    relocate_in_store =
      attrs
      |> RelocateInStore.new()

    with :ok <- App.dispatch(relocate_in_store, consistency: :strong) do
      get(TrackingStatus, attrs[:tracking_uuid])
    else
      reply -> reply
    end
  end

  @doc """
  RequestShipment.
  """
  def request_shipping(attrs \\ %{}) do
    request_shipping =
      attrs
      |> RequestShipping.new()

    with :ok <- App.dispatch(request_shipping, consistency: :strong) do
      get(TrackingStatus, attrs[:tracking_uuid])
    else
      reply -> reply
    end
  end

  @doc """
  DispatchForShipping.
  """
  def dispatch_for_shipping(attrs \\ %{}) do
    dispatch_for_shipping =
      attrs
      |> DispatchForShipping.new()

    with :ok <- App.dispatch(dispatch_for_shipping, consistency: :strong) do
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
