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
    field :length_cm, :integer
    field :level, :string
    field :location_address_label, :string
    field :location_uuid, Ecto.UUID
    field :notes, :string
    field :operator_uuid, Ecto.UUID
    field :package_ext_id, :string
    field :package_uuid, Ecto.UUID
    field :pallet_ext_id, :string
    field :pallet_uuid, Ecto.UUID
    field :rack, :string
    field :repackaged, :boolean, default: false
    field :shelf_color, :string
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
      # :uuid,
      :pallet_uuid,
      :package_uuid,
      :vehicle_uuid,
      :driver_uuid,
      :warehouse_uuid,
      :gate,
      :location_uuid,
      :location_address_label,
      :repackaged,
      :weight_gm,
      :length_cm,
      :width_cm,
      :height_cm,
      :rack,
      :shelf_color,
      :bay,
      :level,
      :is_damaged,
      :value_added_notes,
      :pallet_ext_id,
      :package_ext_id,
      :operator_uuid,
      :note,
      :tags
    ])

    # |> validate_required([:uuid, :pallet_uuid, :package_uuid, :vehicle_uuid, :driver_uuid, :warehouse_uuid, :gate, :location_uuid, :location_address_label, :repackaged, :weight_gm, :length_cm, :width_cm, :height_cm, :rack, :shelf_color, :bay, :level, :is_damaged, :value_added_notes, :pallet_ext_id, :package_ext_id, :operator_uuid, :note, :tags])
  end
end
