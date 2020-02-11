defmodule Ledger.Warehouse.Aggregates.TrackingTest do
  use Ledger.AggregateCase, aggregate: Ledger.Warehouse.Aggregates.Tracking

  alias Ledger.Warehouse.Events.ReceivedFromTransport

  describe "receive from transport" do
    @tag :unit
    test "should succeed when valid" do
      tracking_uuid = UUID.uuid4()

      assert_events(build(:receive_from_transport, tracking_uuid: tracking_uuid), [
        %ReceivedFromTransport{
          tracking_uuid: tracking_uuid,
          package_uuid: package_uuid(),
          vehicle_uuid: vehicle_uuid(),
          driver_uuid: driver_uuid(),
          warehouse_uuid: warehouse_uuid(),
          gate_uuid: gate_uuid(),
          operator_uuid: operator_uuid(),
          notes: reception_notes(),
          tags: reception_tags()
        }
      ])
    end
  end
end
