defmodule Ledger.Warehouse.WarehouseTest do
  use Ledger.DataCase

  alias Ledger.Warehouse
  alias Ledger.Warehouse.Projections.TrackingStatus

  describe "receive from transport" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %TrackingStatus{} = tracking} =
               Warehouse.receive_from_transport(build(:receive_from_transport))

      assert tracking.package_uuid == package_uuid()
      assert tracking.vehicle_uuid == vehicle_uuid()
      assert tracking.driver_uuid == driver_uuid()
      assert tracking.warehouse_uuid == warehouse_uuid()
      assert tracking.gate_uuid == gate_uuid()
      assert tracking.operator_uuid == operator_uuid()
      assert tracking.notes == reception_notes()
      assert tracking.tags == reception_tags()
    end
  end
end
