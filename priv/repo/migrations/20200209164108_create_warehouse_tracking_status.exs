defmodule Ledger.Repo.Migrations.CreateWarehouseTrackingStatus do
  use Ecto.Migration

  def change do
    create table(:warehouse_tracking_status, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :pallet_uuid, :uuid
      add :package_uuid, :uuid
      add :vehicle_uuid, :uuid
      add :driver_uuid, :uuid
      add :warehouse_uuid, :uuid
      add :gate_uuid, :uuid
      add :location_uuid, :uuid
      add :location_address_label, :string
      add :repackaged, :boolean, default: false, null: false
      add :weight_gm, :integer
      add :length_cm, :integer
      add :width_cm, :integer
      add :height_cm, :integer
      add :rack, :string
      add :shelf_color, :string
      add :bay, :string
      add :level, :string
      add :is_damaged, :boolean, default: false, null: false
      add :value_added_notes, :string
      add :pallet_ext_id, :string
      add :package_ext_id, :string
      add :operator_uuid, :uuid
      add :notes, :string
      add :tags, :string

      timestamps()
    end
  end
end
