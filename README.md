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
      "warehouseUUID": "e682bb16-5738-46c6-abbd-33575b5379a0",
      "gateUUID": "cb650975-0f77-47bd-ba86-44352bc1649a",
      "operatorUUID": "d61b3b98-643e-4e80-a621-802f5cfb636b",
      "vehicleUUID": "9f1ba2b5-91a5-4907-8403-e94a1f8b1bd8",
      "driverUUID": "2befab04-9971-4351-a8d4-14e62da96e80",
      "palletExtID": "some-ext-code",
      "packageExtID": "some-ext-code",
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
      "trackingUUID": "e866596d-57bc-4e6c-9ce3-7e60fe18fbe4",
      "operatorUUID": "d61b3b98-643e-4e80-a621-802f5cfb636b",
      "palletUUID": "7cdf9aa6-4816-41d2-9773-4894146fbec1",
      "packageUUID": "f577bfd3-b6f3-43da-8c1b-a24d97c2246d",
      "lengthCm": "50",
      "widthCm": "80",
      "heightCm": "40",
      "weightGm": "40",
      "picture_front": "data:image/png;base64,iVBORw0KG...II=",
      "picture_back": "data:image/png;base64,iVBORw0KG...II=",
      "picture_side_left": "data:image/png;base64,iVBORw0KG...II=",
      "picture_side_right": "data:image/png;base64,iVBORw0KG...II=",
      "picture_top": "data:image/png;base64,iVBORw0KG...II=",
      "heightCm": "40",
      "notes": "Sample note",
      "tags": "tag1, tags2, tag3"
    }
  }
}
```

**RelocateInStore**

```json
{
  "payload": {
    "command": "relocate-to-store",
    "payload": {
      "trackingUUID": "e866596d-57bc-4e6c-9ce3-7e60fe18fbe4",
      "operatorUUID": "d61b3b98-643e-4e80-a621-802f5cfb636b",
      "shelfColor": "green",
      "rack": "A",
      "bay": "02",
      "level": "E",
      "position": "5",
      "notes": "Sample note",
      "tags": "tag1, tags2, tag3"
    }
  }
}
```

### Warehouse ᐅ Cloud
