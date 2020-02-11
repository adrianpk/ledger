defmodule Ledger.Warehouse.Projectors.TrackingStatus do
  use Commanded.Projections.Ecto,
    application: Ledger.App,
    name: "Ledger.Warehouse.Projectors.TrackingStatus",
    consistency: :strong

  alias Ledger.Warehouse.Events.ReceivedFromTransport
  alias Ledger.Warehouse.Projections.TrackingStatus

  project %ReceivedFromTransport{} = received do
    Ecto.Multi.insert(multi, :tracking_status, %TrackingStatus{
      uuid: received.tracking_uuid,
      package_uuid: received.package_uuid,
      vehicle_uuid: received.vehicle_uuid,
      driver_uuid: received.driver_uuid,
      warehouse_uuid: received.warehouse_uuid,
      gate_uuid: received.gate_uuid,
      operator_uuid: received.operator_uuid,
      notes: received.notes,
      tags: received.tags
    })
  end
end