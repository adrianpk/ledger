defmodule Ledger.Warehouse.WarehouseTest do
  use Ledger.DataCase

  alias Ledger.Warehouse
  alias Ledger.Warehouse.Projections.Tracking
  alias Ledger.Factory

  describe "receive from transport" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %Tracking{} = tracking} = Warehouse.register_tracking(build(:tracking))

      assert tracking.package_uuid == package_uuid()
      assert tracking.vehicle_uuid == vehicle_uuid()
      assert tracking.driver_uuid == driver_uuid()
      assert tracking.warehouse_uuid == warehouse_uuid()
      assert tracking.gate_uuid == gate_uuid()
      assert tracking.operator_uuid == operatpr_uuid()
      assert tracking.notes == reception_notes()
      assert tracking.tags == reception_tags()
    end
  end
end
