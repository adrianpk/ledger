defmodule Ledger.Warehouse.Aggregates.Tracking do
  defstruct uuid: nil,
            package_uuid: nil,
            vehicle_uuid: nil,
            driver_uuid: nil,
            pallet_ext_id: nil,
            package_ext_id: nil,
            pallet_uuiid: nil,
            package_uuid: nil,
            warehouse_uuid: nil,
            gate_uuid: nil,
            operator_uuid: nil,
            pallet_uuid: nil,
            shelf_color: nil,
            rack: nil,
            bay: nil,
            level: nil,
            position: nil,
            length_cm: nil,
            width_cm: nil,
            height_cm: nil,
            weight_gm: nil,
            picture_front: nil,
            picture_back: nil,
            picture_left: nil,
            picture_right: nil,
            picture_top: nil,
            is_repackaged: nil,
            is_damaged: nil,
            notes: nil,
            tags: nil

  @type t :: %__MODULE__{
          uuid: UUID.t(),
          package_uuid: UUID.t() | nil,
          vehicle_uuid: UUID.t() | nil,
          driver_uuid: UUID.t() | nil,
          pallet_ext_id: String.t() | nil,
          package_ext_id: String.t() | nil,
          pallet_uuid: UUID.t() | nil,
          package_uuid: UUID.t() | nil,
          warehouse_uuid: UUID.t() | nil,
          gate_uuid: UUID.t() | nil,
          operator_uuid: UUID.t() | nil,
          pallet_uuid: UUID.t() | nil,
          shelf_color: String.t() | nil,
          rack: String.t() | nil,
          bay: String.t() | nil,
          level: String.t() | nil,
          position: String.t() | nil,
          length_cm: Integer.t() | nil,
          width_cm: Integer.t() | nil,
          height_cm: Integer.t() | nil,
          weight_gm: Integer.t() | nil,
          picture_front: String.t() | nil,
          picture_back: String.t() | nil,
          picture_back: String.t() | nil,
          picture_left: String.t() | nil,
          picture_right: String.t() | nil,
          picture_top: String.t() | nil,
          is_repackaged: Boolean.t() | nil,
          is_damaged: Boolean.t() | nil,
          tags: String.t() | nil,
          notes: UUID.t() | nil
        }

  alias Ledger.Warehouse.Commands.{
    ReceiveFromTransport,
    ClassifyItem,
    RelocateInStore
  }

  alias Ledger.Warehouse.Events.{
    ReceivedFromTransport,
    ClassifiedItem,
    RelocatedInStore
  }

  alias Ledger.Warehouse.Aggregates.Tracking

  @doc """
  Receive from transport.
  """
  # def execute(%Tracking{uuid: nil}, %ReceiveFromTransport{} = to_receive) do
  def execute(%Tracking{uuid: nil}, %ReceiveFromTransport{} = to_receive) do
    %ReceivedFromTransport{
      tracking_uuid: to_receive.tracking_uuid,
      vehicle_uuid: to_receive.vehicle_uuid,
      driver_uuid: to_receive.driver_uuid,
      pallet_ext_id: to_receive.pallet_ext_id,
      package_ext_id: to_receive.package_ext_id,
      warehouse_uuid: to_receive.warehouse_uuid,
      gate_uuid: to_receive.gate_uuid,
      operator_uuid: to_receive.operator_uuid,
      notes: to_receive.notes,
      tags: to_receive.tags
    }
  end

  @doc """
  Classify item.
  """
  def execute(
        %Tracking{uuid: tracking_uuid},
        %ClassifyItem{tracking_uuid: tracking_uuid} = to_classify
      ) do
    %ClassifiedItem{
      tracking_uuid: tracking_uuid,
      operator_uuid: to_classify.operator_uuid,
      pallet_uuid: to_classify.pallet_uuid,
      package_uuid: to_classify.package_uuid,
      length_cm: to_classify.length_cm,
      width_cm: to_classify.width_cm,
      height_cm: to_classify.height_cm,
      weight_gm: to_classify.weight_gm,
      picture_front: to_classify.picture_front,
      picture_back: to_classify.picture_back,
      picture_left: to_classify.picture_left,
      picture_right: to_classify.picture_right,
      picture_top: to_classify.picture_top,
      is_repackaged: to_classify.is_repackaged,
      is_damaged: to_classify.is_damaged,
      notes: to_classify.notes,
      tags: to_classify.tags
    }
  end

  @doc """
  Relocate to storage.
  """
  # def execute(%Tracking{uuid: nil}, %RelocateInStore{} = to_relocate) do
  def execute(%Tracking{uuid: _uuid}, %RelocateInStore{} = to_relocate) do
    %RelocatedInStore{
      tracking_uuid: to_relocate.tracking_uuid,
      operator_uuid: to_relocate.operator_uuid,
      shelf_color: to_relocate.shelf_color,
      rack: to_relocate.rack,
      bay: to_relocate.bay,
      level: to_relocate.level,
      position: to_relocate.position,
      notes: to_relocate.notes,
      tags: to_relocate.tags
    }
  end

  # state mutators
  def apply(%Tracking{} = tracking, %ReceivedFromTransport{} = received) do
    %Tracking{
      tracking
      | uuid: received.tracking_uuid,
        vehicle_uuid: received.vehicle_uuid,
        driver_uuid: received.driver_uuid,
        pallet_ext_id: received.pallet_ext_id,
        package_ext_id: received.package_ext_id,
        warehouse_uuid: received.warehouse_uuid,
        gate_uuid: received.gate_uuid,
        operator_uuid: received.operator_uuid,
        notes: received.notes,
        tags: received.tags
    }
  end


  def apply(
        %Tracking{} = tracking,
        %ClassifiedItem{} = classified
      ) do
    %Tracking{
      tracking
      | uuid: classified.tracking_uuid,
        pallet_uuid: classified.pallet_uuid,
        package_uuid: classified.package_uuid,
        operator_uuid: classified.operator_uuid,
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
        notes: tracking.notes <> "\n" <> classified.notes,
        tags: tracking.tags <> ", " <> classified.tags
    }
  end


  def apply(
        %Tracking{uuid: tracking_uuid} = tracking,
        %ClassifiedItem{tracking_uuid: tracking_uuid} = classified
      ) do
    %Tracking{
      tracking
      | pallet_uuid: classified.pallet_uuid,
        package_uuid: classified.package_uuid,
        operator_uuid: classified.operator_uuid,
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
        notes: tracking.notes <> "\n" <> classified.notes,
        tags: tracking.tags <> ", " <> classified.tags
    }
  end

  def apply(
        %Tracking{uuid: tracking_uuid} = tracking,
        %RelocatedInStore{tracking_uuid: tracking_uuid} = relocated
      ) do
    %Tracking{
      tracking
      | operator_uuid: relocated.pallet_uuid,
        shelf_color: relocated.shelf_color,
        rack: relocated.shelf_color,
        bay: relocated.shelf_color,
        level: relocated.shelf_color,
        position: relocated.shelf_color,
        notes: tracking.notes <> "\n" <> relocated.notes,
        tags: tracking.tags <> ", " <> relocated.tags
    }
  end
end
