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
            shipping_address: nil,
            notes: nil,
            location: nil,
            addressee: nil,
            shipping_address: nil,
            location: nil,
            status: nil,
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
          location: String.t() | nil,
          status: String.t() | nil,
          tags: String.t() | nil,
          addressee: String.t() | nil,
          shipping_address: nil,
          notes: UUID.t() | nil
        }

  # Status
  @received_st "received"
  @classified_st "classified"
  @stored_st "stored"
  @shipping_requested_st "shipping-requested"
  @dispatched_st "dispatched"
  # Location
  @ingate_loc "in-gate"
  @reception_loc "reception"
  @store_loc "store"
  @damaged_loc "damaged-store"
  @outdesk_loc "out-desk"
  @damaged_loc "damaged-store"
  @outgate_loc "out-gate"

  alias Ledger.Warehouse.Commands.{
    ReceiveFromTransport,
    ClassifyItem,
    RelocateInStore,
    RequestShipping,
    DispatchForShipping
  }

  alias Ledger.Warehouse.Events.{
    ReceivedFromTransport,
    ClassifiedItem,
    RelocatedInStore,
    RequestedShipping,
    DispatchedForShipping
  }

  alias Ledger.Warehouse.Aggregates.Tracking

  @doc """
  Receive from transport.
  """
  def execute(%Tracking{uuid: nil}, %ReceiveFromTransport{} = command) do
    %ReceivedFromTransport{
      tracking_uuid: command.tracking_uuid,
      vehicle_uuid: command.vehicle_uuid,
      driver_uuid: command.driver_uuid,
      pallet_ext_id: command.pallet_ext_id,
      package_ext_id: command.package_ext_id,
      warehouse_uuid: command.warehouse_uuid,
      gate_uuid: command.gate_uuid,
      operator_uuid: command.operator_uuid,
      notes: command.notes,
      tags: command.tags,
      status: @received_st,
      location: @ingate_loc
    }
  end

  @doc """
  Classify item.
  """
  def execute(
        %Tracking{uuid: tracking_uuid},
        %ClassifyItem{tracking_uuid: tracking_uuid} = command
      ) do
    %ClassifiedItem{
      tracking_uuid: tracking_uuid,
      operator_uuid: command.operator_uuid,
      pallet_uuid: command.pallet_uuid,
      package_uuid: command.package_uuid,
      length_cm: command.length_cm,
      width_cm: command.width_cm,
      height_cm: command.height_cm,
      weight_gm: command.weight_gm,
      picture_front: command.picture_front,
      picture_back: command.picture_back,
      picture_left: command.picture_left,
      picture_right: command.picture_right,
      picture_top: command.picture_top,
      is_repackaged: command.is_repackaged,
      is_damaged: command.is_damaged,
      notes: command.notes,
      tags: command.tags,
      status: @classified_st,
      location: @reception_loc
    }
  end

  @doc """
  Relocate in store.
  """
  def execute(
        %Tracking{uuid: tracking_uuid},
        %RelocateInStore{tracking_uuid: tracking_uuid} = command
      ) do
    %RelocatedInStore{
      tracking_uuid: command.tracking_uuid,
      operator_uuid: command.operator_uuid,
      shelf_color: command.shelf_color,
      rack: command.rack,
      bay: command.bay,
      level: command.level,
      position: command.position,
      notes: command.notes,
      tags: command.tags,
      status: @stored_st,
      location: @store_loc
    }
  end

  @doc """
  Request shipment.
  """
  def execute(
        %Tracking{uuid: tracking_uuid},
        %RequestShipping{tracking_uuid: tracking_uuid} = command
      ) do
    %RequestedShipping{
      tracking_uuid: command.tracking_uuid,
      operator_uuid: command.operator_uuid,
      addressee: command.addressee,
      shipping_address: command.shipping_address,
      notes: command.notes,
      tags: command.tags,
      status: @shipping_requested_st,
      location: @store_loc
    }
  end

  @doc """
  Dispatch for shipping.
  """
  def execute(
        %Tracking{uuid: tracking_uuid},
        %DispatchForShipping{tracking_uuid: tracking_uuid} = command
      ) do
    %DispatchedForShipping{
      tracking_uuid: command.tracking_uuid,
      gate_uuid: command.gate_uuid,
      operator_uuid: command.operator_uuid,
      notes: command.notes,
      tags: command.tags,
      status: @dispatched_st,
      location: @outgate_loc
    }
  end

  # state mutators
  def apply(%Tracking{} = tracking, %ReceivedFromTransport{} = event) do
    %Tracking{
      tracking
      | uuid: event.tracking_uuid,
        vehicle_uuid: event.vehicle_uuid,
        driver_uuid: event.driver_uuid,
        pallet_ext_id: event.pallet_ext_id,
        package_ext_id: event.package_ext_id,
        warehouse_uuid: event.warehouse_uuid,
        gate_uuid: event.gate_uuid,
        operator_uuid: event.operator_uuid,
        notes: event.notes,
        tags: event.tags,
        status: event.status,
        location: event.location
    }
  end

  def apply(
        %Tracking{uuid: tracking_uuid} = tracking,
        %ClassifiedItem{tracking_uuid: tracking_uuid} = event
      ) do
    %Tracking{
      tracking
      | pallet_uuid: event.pallet_uuid,
        package_uuid: event.package_uuid,
        operator_uuid: event.operator_uuid,
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
        notes: tracking.notes <> "\n" <> event.notes,
        tags: tracking.tags <> ", " <> event.tags,
        status: event.status,
        location: event.location
    }
  end

  def apply(
        %Tracking{uuid: tracking_uuid} = tracking,
        %RelocatedInStore{tracking_uuid: tracking_uuid} = event
      ) do
    %Tracking{
      tracking
      | operator_uuid: event.operator_uuid,
        shelf_color: event.shelf_color,
        rack: event.shelf_color,
        bay: event.shelf_color,
        level: event.shelf_color,
        position: event.shelf_color,
        notes: tracking.notes <> "\n" <> event.notes,
        tags: tracking.tags <> ", " <> event.tags,
        status: event.status,
        location: event.location
    }
  end


  def apply(
        %Tracking{uuid: tracking_uuid} = tracking,
        %RequestedShipping{tracking_uuid: tracking_uuid} = event
      ) do
    %Tracking{
      tracking
      | operator_uuid: event.operator_uuid,
        addressee: event.addressee,
        shipping_address: event.shipping_address,
        tags: event.tags,
        status: event.status,
        location: event.location
    }
  end

  def apply(
        %Tracking{uuid: tracking_uuid} = tracking,
        %DispatchedForShipping{tracking_uuid: tracking_uuid} = event
      ) do
    %Tracking{
      tracking
      | operator_uuid: event.operator_uuid,
        gate_uuid: event.gate_uuid,
        notes: event.notes,
        tags: event.tags,
        status: event.status,
        location: event.location
    }
  end
end
