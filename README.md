# Ledger

## Project

[Kanban](https://github.com/adrianpk/ledger/projects/1)

[Event sourcing](https://martinfowler.com/eaaDev/EventSourcing.html) & [CQRC](https://martinfowler.com/bliki/CQRS.html) in a proof of concept application based on Elixir, Phoenix, and RabbitMQ.

## Notes

This implementation does not pretend to be an example of a real world application. Its logic is simple, incomplete and probably not adjusted to a real use case. It is only a quick exercise just to see "how it feels" to implement a system based on event-sourcing and CQRS in a functional language like Elixir. I am also interested in test RabbitMQ libs in order to contrast it with other implementations in imperative languages like Go.

## Commands

This is a proof of concept, UUIDs has been chosen as standard identifier to simplify the implementation

UUIDs can be easily generated offline and be unique across applications. However, it would be trivial to modify the system to accept another format of values for each required identifiers. (Topaz/Jewel, Mifare, FeliCa, ISO14443-4A, ISO14443-4B or just only a simple string).

At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)

This is a proof of concept, in a real world implementation there would probably be additional commands that would allow users to request subsequent chain actions. i.e.: 'relocate-in-storage' action would be preceded by a 'request-relocation-in-storage' by way of ensuring any preparations at origin and destination as well as to send the necessary notifications.

Remember also that the authorization and authentication aspects are beyond the scope of this implementation.

## Routes

| Method | Path      | Controller                | Function |
|--------|-----------|---------------------------|----------|
| POST   | /api/send | LedgerWeb.QueueController | :send    |

## Dev setup

### Start RabbitMQ

**If docker image was not download before**

```shell
$ make rabbitmq-start
```

**if it was launched before**

```shell
$ make rabbitmq-restart
```

**Start the app**

```shell
$ make run
```

**Send a sample message to warehouse**

```shell
$ make send-receive-from-transport
```

### Warehouse ᐅ Cloud

**ReceiveFromTransport**

```json
{
  "command": "receive-from-transport",
  "arguments": {
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
```

**ClassifyItem**

```json
{
  "command": "classify-item",
  "arguments": {
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
```

**Note:** Images are stored are stored in the database (Base64 encoding) along with other properties.
This gives some advantage if you want to have a single backup of all data but it can be impact in performant depending on context.
Eventually fields can be used to store path while images are saved in disk, buck, etc.

**RelocateInStore**

```json
{
  "command": "relocate-in-store",
  "arguments": {
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
```

**DispatchForShipping**

```json
{
  "command": "dispatch-for-shipping",
  "arguments": {
    "gate_uuid": "cb650975-0f77-47bd-ba86-44352bc1649a",
    "operator_uuid": "d61b3b98-643e-4e80-a621-802f5cfb636b",
    "notes": "Sample note",
    "tags": "tag1, tags2, tag3"
  }
}
```

**Ship**

**Not implemented yet**

```json
{
  "command": "ship",
  "arguments": {
    "vehicle_uuid": "9f1ba2b5-91a5-4907-8403-e94a1f8b1bd8",
    "driver_uuid": "2befab04-9971-4351-a8d4-14e62da96e80",
    "notes": "Sample note",
    "tags": "tag1, tags2, tag3"
  }
}
```

### Warehouse ᐅ Cloud

**RequestShipment**

```json
{
  "command": "request-shipment",
  "arguments": {
    "tracking_uuid": "e866596d-57bc-4e6c-9ce3-7e60fe18fbe4",
    "operator_uuid": "d61b3b98-643e-4e80-a621-802f5cfb636b",
    "addressee": "Mrs. Layla Prescott",
    "shipping_address": "Französisch Buchholz, 13125 Berlin, Germany",
    "notes": "13:00 to 17:00 only",
    "tags": "tag10"
  }
}
```
