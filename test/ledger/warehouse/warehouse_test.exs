defmodule Ledger.Warehouse.WarehouseTest do
  use Ledger.DataCase

  alias Ledger.Warehouse
  alias Ledger.Warehouse.Projections.TrackingStatus

  describe "receive from transport" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %TrackingStatus{} = tracking} =
               Warehouse.receive_from_transport(build(:receive_from_transport))

      assert tracking.pallet_ext_id == pallet_ext_id()
      assert tracking.package_ext_id == package_ext_id()
      assert tracking.vehicle_uuid == vehicle_uuid()
      assert tracking.driver_uuid == driver_uuid()
      assert tracking.warehouse_uuid == warehouse_uuid()
      assert tracking.gate_uuid == gate_uuid()
      assert tracking.operator_uuid == operator_uuid()
      assert tracking.notes == reception_notes()
      assert tracking.tags == reception_tags()
      assert tracking.status == "received"
      assert tracking.location == "in-gate"
    end
  end

  describe "classify item" do
    @tag :integration
    test "should succeed with valid data" do
      ts = sample_tracking_status()

      attrs =
        build(:classify_item)
        |> Map.put(:tracking_uuid, ts.uuid)

       assert {:ok, %TrackingStatus{} = tracking} = Warehouse.classify_item(attrs)
      assert tracking.operator_uuid == operator_uuid()
      assert tracking.pallet_uuid == pallet_uuid()
      assert tracking.package_uuid == package_uuid()
      assert tracking.length_cm == length()
      assert tracking.width_cm == width()
      assert tracking.height_cm == height()
      assert tracking.weight_gm == weight()
      assert tracking.picture_front == sample_front_image()
      assert tracking.picture_back == ""
      assert tracking.picture_left == ""
      assert tracking.picture_right == ""
      assert tracking.picture_top == ""
      assert tracking.is_repackaged == false
      assert tracking.is_damaged == false
      assert tracking.notes == classify_notes()
      assert tracking.tags == classify_tags()
      assert tracking.status == "classified"
      assert tracking.location == "reception"
    end
  end


  describe "relocate in store" do
    @tag :integration
    test "should succeed with valid data" do
      ts = sample_tracking_status()

      attrs =
        build(:relocate_in_store)
        |> Map.put(:tracking_uuid, ts.uuid)

       assert {:ok, %TrackingStatus{} = tracking} = Warehouse.relocate_in_store(attrs)
       assert tracking.operator_uuid == operator_uuid()
       assert tracking.shelf_color == shelf_color()
       assert tracking.rack == rack()
       assert tracking.bay == bay()
       assert tracking.level == level()
       assert tracking.position == position()
       assert tracking.notes == relocate_notes()
       assert tracking.tags == relocate_tags()
      assert tracking.status == "stored"
      assert tracking.location == "store"
    end
  end

  defp sample_tracking_status() do
    {:ok, tracking} = Warehouse.receive_from_transport(build(:receive_from_transport))
    tracking
  end
end
