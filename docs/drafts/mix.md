# Mix

## Tracking Status Aggregate

```shell
mix phx.gen.json Warehouse TrackingStatus tracking_status uuid:uuid pallet_uuid:string package_uuid:uuid vehicle_uuid:uuid driver_uuid:uuid warehouse_uuid:uuid gate:uuid shipping_address:string repackaged:boolean weight_gm:integer length_cm:integer width_cm:integer height_cm:integer rack:string shelf_color:string bay:string level:string is_damaged:boolean value_added_notes:string pallet_ext_id:string package_ext_id:string operator_uuid:uuid note:string tags:string --table warehouse_tracking_status
```
