defmodule Ledger.Warehouse.Projectors.TrackingStatus do
  use Commanded.Projections.Ecto,
    application: Ledger.App,
    name: "Ledger.Warehouse.Projectors.TrackingStatus",
    consistency: :strong

  alias Ecto.{Changeset, Multi}

  alias Ledger.Warehouse

  alias Ledger.Warehouse.Events.{
    ReceivedFromTransport,
    ClassifiedItem
  }

  alias Ledger.Warehouse.Projections.TrackingStatus

  project %ReceivedFromTransport{} = received do
    Ecto.Multi.insert(multi, :tracking_status, %TrackingStatus{
      uuid: received.tracking_uuid,
      vehicle_uuid: received.vehicle_uuid,
      driver_uuid: received.driver_uuid,
      pallet_ext_id: received.pallet_ext_id,
      package_ext_id: received.package_ext_id,
      warehouse_uuid: received.warehouse_uuid,
      gate_uuid: received.gate_uuid,
      operator_uuid: received.operator_uuid,
      notes: received.notes,
      tags: received.tags
    })
  end


  project(%ClassifiedItem{} = classified, fn multi ->
    update_tracking_status(multi, classified.tracking_uuid,
      #uuid: classified.tracking_uuid,
      pallet_uuid: classified.pallet_uuid,
      package_uuid: classified.package_uuid,
      length_cm: classified.length_cm,
      width_cm: classified.width_cm,
      height_cm: classified.height_cm,
      weight_gm: classified.weight_gm,
      picture_front: classified.picture_front,
      picture_back: classified.picture_back,
      picture_left: classified.picture_left,
      picture_right: classified.picture_right,
      picture_top: classified.picture_top,
      is_repackaged: classified.is_repackaged,
      is_damaged: classified.is_damaged,
      notes: classified.notes,
      tags: classified.tags
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
