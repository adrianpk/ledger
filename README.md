# Ledger

## Commands

This is a proof of concept, UUIDs has been chosen as standard identifier to simplify the implementation

UUIDs can be easily generated offline and be unique across applications. However, it would be trivial to modify the system to accept another format of values for each required identifiers. (Topaz/Jewel, Mifare, FeliCa, ISO14443-4A, ISO14443-4B or just only a simple string).

At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)

### Warehouse ᐅ Cloud

**ReceiveFromTransport**

```json
{
  "payload": {
    "command": "receive-from-transport",
    "payload": {
      "warehouse_uuid": "e682bb16-5738-46c6-abbd-33575b5379a0",
      "gate_uuid": "cb650975-0f77-47bd-ba86-44352bc1649a",
      "operator_uuid": "d61b3b98-643e-4e80-a621-802f5cfb636b",
      "vehicle_uuid": "9f1ba2b5-91a5-4907-8403-e94a1f8b1bd8",
      "driver_uuid": "2befab04-9971-4351-a8d4-14e62da96e80",
      "pallet_ext_id": "some-ext-code",
      "package_ext_id": "some-ext-code",
      "notes": "Sample note",
      "tags": "tag1, tags2, tag3"
    }
  }
}
```

**ClassifyItem**

```json
{
  "payload": {
    "command": "classify-item",
    "payload": {
      "tracking_uuid": "e866596d-57bc-4e6c-9ce3-7e60fe18fbe4",
      "operator_uuid": "d61b3b98-643e-4e80-a621-802f5cfb636b",
      "pallet_uuid": "7cdf9aa6-4816-41d2-9773-4894146fbec1",
      "package_uuid": "f577bfd3-b6f3-43da-8c1b-a24d97c2246d",
      "length_cm": "50",
      "width_cm": "80",
      "height_cm": "40",
      "weight_gm": "40",
      "picture_front": "data:image/png;base64,iVBORw0KG...II=",
      "picture_back": "data:image/png;base64,iVBORw0KG...II=",
      "picture_left": "data:image/png;base64,iVBORw0KG...II=",
      "picture_right": "data:image/png;base64,iVBORw0KG...II=",
      "picture_top": "data:image/png;base64,iVBORw0KG...II=",
      "notes": "Note updated",
      "tags": "tag4, tag5, tag6"
    }
  }
}
```

**Note:** Images are stored are stored in the database (Base64 encoding) along with other properties.
This gives some advantage if you want to have a single backup of all data but it can be impact in performant dependinng on context.
Eventually fields can be used to  store path while images are saved in disk, buck, etc.


**RelocateInStore**

```json
{
  "payload": {
    "command": "relocate-to-store",
    "payload": {
      "tracking_uuid": "e866596d-57bc-4e6c-9ce3-7e60fe18fbe4",
      "operator_uuid": "d61b3b98-643e-4e80-a621-802f5cfb636b",
      "shelf_color": "green",
      "rack": "A",
      "bay": "02",
      "level": "E",
      "position": "5",
      "notes": "Note updated again",
      "tags": "tag7, tags8, tag9"
    }
  }
}
```

**DispatchForShipping**

```json
{
  "payload": {
    "command": "receive-from-transport",
    "payload": {
      "gate_uuid": "cb650975-0f77-47bd-ba86-44352bc1649a",
      "operator_uuid": "d61b3b98-643e-4e80-a621-802f5cfb636b",
      "notes": "Sample note",
      "tags": "tag1, tags2, tag3"
    }
  }
}
```

**Ship**

**Not implemented yet**
```json
{
  "payload": {
    "command": "receive-from-transport",
    "payload": {
      "vehicle_uuid": "9f1ba2b5-91a5-4907-8403-e94a1f8b1bd8",
      "driver_uuid": "2befab04-9971-4351-a8d4-14e62da96e80",
      "notes": "Sample note",
      "tags": "tag1, tags2, tag3"
    }
  }
}
```

### Warehouse ᐅ Cloud


**RequestShipment**

```json
{
  "payload": {
    "command": "request-shipment",
    "payload": {
      "tracking_uuid": "e866596d-57bc-4e6c-9ce3-7e60fe18fbe4",
      "operator_uuid": "d61b3b98-643e-4e80-a621-802f5cfb636b",
      "addressee": "Mrs. Layla Prescott",
      "shipping_address": "Französisch Buchholz, 13125 Berlin, Germany",
      "notes": "13:00 to 17:00 only",
      "tags": "tag10"
    }
  }
}
```

## Pending
* Comple AMQP integration (RabbitMQ) queues
  * App can now subscribe to a queue, redirect command and payload to controller but the latter does not start processing them.
  * Basic controller to send commands to the outboud queue (message to warehouse)
  * Make queue parameters configurable (mix / envars)
  * Add more tests
  * Docs
