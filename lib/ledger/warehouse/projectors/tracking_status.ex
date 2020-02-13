defmodule Ledger.Warehouse.Projectors.TrackingStatus do
  use Commanded.Projections.Ecto,
    application: Ledger.App,
    name: "Ledger.Warehouse.Projectors.TrackingStatus",
    consistency: :strong

  alias Ledger.Warehouse.Events.{
    ReceivedFromTransport,
    ClassifiedItem,
    RelocatedInStore
  }

  alias Ledger.Warehouse.Projections.TrackingStatus

  project %ReceivedFromTransport{} = event do
    Ecto.Multi.insert(multi, :tracking_status, %TrackingStatus{
      uuid: event.tracking_uuid,
      vehicle_uuid: event.vehicle_uuid,
      driver_uuid: event.driver_uuid,
      pallet_ext_id: event.pallet_ext_id,
      package_ext_id: event.package_ext_id,
      warehouse_uuid: event.warehouse_uuid,
      gate_uuid: event.gate_uuid,
      operator_uuid: event.operator_uuid,
      notes: event.notes,
      tags: event.tags,
      status: event.status
    })
  end


  project(%ClassifiedItem{} = event, fn multi ->
    update_tracking_status(multi, event.tracking_uuid,
      operator_uuid: event.operator_uuid,
      pallet_uuid: event.pallet_uuid,
      package_uuid: event.package_uuid,
      length_cm: event.length_cm,
      width_cm: event.width_cm,
      height_cm: event.height_cm,
      weight_gm: event.weight_gm,
      picture_front: event.picture_front,
      picture_back: event.picture_back,
      picture_left: event.picture_left,
      picture_right: event.picture_right,
      picture_top: event.picture_top,
      is_repackaged: event.is_repackaged,
      is_damaged: event.is_damaged,
      notes: event.notes,
      tags: event.tags,
      status: event.status
    )
  end)


  project(%RelocatedInStore{} = event, fn multi ->
    update_tracking_status(multi, event.tracking_uuid,
      operator_uuid: event.operator_uuid,
      shelf_color: event.shelf_color,
      rack: event.rack,
      bay: event.bay,
      level: event.level,
      position: event.position,
      notes: event.notes,
      tags: event.tags,
      status: event.status
    )
  end)

  defp update_tracking_status(multi, tracking_uuid, changes) do
    Ecto.Multi.update_all(multi, :tracking_status, tracking_status_query(tracking_uuid),
      set: changes
    )
  end

  defp tracking_status_query(tracking_uuid) do
    from(ts in TrackingStatus, where: ts.uuid == ^tracking_uuid)
  end
end
