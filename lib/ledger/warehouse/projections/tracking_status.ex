defmodule Ledger.Warehouse.Projections.TrackingStatus do
  use Ledger.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime_usec]

  schema "warehouse_tracking_status" do
    field :bay, :string
    field :driver_uuid, Ecto.UUID
    field :gate_uuid, Ecto.UUID
    field :height_cm, :integer
    field :is_damaged, :boolean, default: false
    field :is_repackaged, :boolean, default: false
    field :length_cm, :integer
    field :level, :string
    field :location, :string
    field :shipping_address, :string
    field :notes, :string
    field :operator_uuid, Ecto.UUID
    field :package_ext_id, :string
    field :package_uuid, Ecto.UUID
    field :pallet_ext_id, :string
    field :pallet_uuid, Ecto.UUID
    field :picture_back, :string
    field :picture_front, :string
    field :picture_left, :string
    field :picture_right, :string
    field :picture_top, :string
    field :position, :string
    field :rack, :string
    field :shelf_color, :string
    field :status, :string
    field :tags, :string
    field :value_added_notes, :string
    field :vehicle_uuid, Ecto.UUID
    field :warehouse_uuid, Ecto.UUID
    field :weight_gm, :integer
    field :width_cm, :integer

    timestamps()
  end

  @doc false
  def changeset(tracking_status, attrs) do
    tracking_status
    |> cast(attrs, [
      :pallet_uuid,
      :package_uuid,
      :vehicle_uuid,
      :driver_uuid,
      :warehouse_uuid,
      :gate,
      :shipping_address,
      :weight_gm,
      :location,
      :length_cm,
      :width_cm,
      :height_cm,
      :rack,
      :shelf_color,
      :bay,
      :level,
      :is_damaged,
      :is_repackaged,
      :value_added_notes,
      :pallet_ext_id,
      :package_ext_id,
      :picture_back,
      :picture_front,
      :picture_left,
      :picture_right,
      :picture_top,
      :position,
      :operator_uuid,
      :note,
      :status,
      :tags
    ])

    # |> validate_required([:uuid, :pallet_uuid, :package_uuid, :vehicle_uuid, :driver_uuid, :warehouse_uuid, :gate, :shipping_address, :repackaged, :weight_gm, :length_cm, :width_cm, :height_cm, :rack, :shelf_color, :bay, :level, :is_damaged, :value_added_notes, :pallet_ext_id, :package_ext_id, :operator_uuid, :note, :tags])
  end
end
