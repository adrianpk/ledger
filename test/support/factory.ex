defmodule Ledger.Factory do
  use ExMachina

  alias Ledger.Warehouse.Commands.ReceiveFromTransport

  # @uuid1 UUID.info("f8e2702b-783e-40bf-9df8-3aaae36a599c")
  # @uuid1 "f8e2702b-783e-40bf-9df8-3aaae36a599c"
  @uuid1 UUID.uuid4()
  def package_uuid, do: @uuid1
  @uuid2 "e2f63c25-e582-4da5-ad73-2fcdf604fc05"
  def vehicle_uuid, do: @uuid2
  @uuid3 "30e454f4-020f-4033-b100-cf51ec79efd0"
  def driver_uuid, do: @uuid3
  @uuid4 "7fa2ae0b-a0d2-4875-a44b-97d17b94283e"
  def warehouse_uuid, do: @uuid4
  @uuid5 "327be821-024f-48a7-a63c-5fb5564f5e06"
  def gate_uuid, do: @uuid5
  @uuid6 "67e78856-211e-4910-b4fb-8ff5d258f4e1"
  def operator_uuid, do: @uuid6
  @notes1 "Reception notes."
  def reception_notes, do: @notes1
  @tags1 "tagA, tagB, tagsC"
  def reception_tags, do: @tags1

  def receive_from_transport_factory do
    %{
      package_uuid: package_uuid(),
      vehicle_uuid: vehicle_uuid(),
      driver_uuid: driver_uuid(),
      warehouse_uuid: warehouse_uuid(),
      gate_uuid: gate_uuid(),
      operator_uuid: operator_uuid(),
      notes: reception_notes(),
      tags: reception_tags()
    }
  end
end
