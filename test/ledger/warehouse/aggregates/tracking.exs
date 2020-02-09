alias Ledger.Warehouse.Events.TrackingRegistered

describe "enter from truck" do
  @tag :unit
  test "should succeed when valid" do
    tracking_uuid = UUID.uuid4()

    assert_events(build(:enter_from_truck, tracking_uuid: tracking_uuid), [
      %ReceivedFromTransport{
        tracking_uuid: tracking_uuid,
        package_uuid: UUID.uuid4(),
        vehicle_uuid: UUID.uuid4(),
        driver_uuid: UUID.uuid4(),
        warehouse_uuid: UUID.uuid4(),
        gate_uuid: UUID.uuid4(),
        operator_uuid: UUID.uuid4(),
        notes: "Recepetion notes",
        tags: "tag1, tag2"
      }
    ])
  end
end
