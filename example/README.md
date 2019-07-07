# Example of using flutter_ble_uart
Unfortunately there is no full example yet, but here are some brief pointers.

## Scanning for devices
To start a scan for devices, you must get an instance of the `SerialConnectionProvider` and call the `scan` method.

```dart
// Get instance
var provider = SerialConnectionProvider();

// Start scan
var subscription = provider
  .scan(timeout: Duration(seconds: 5))
  .listen(_onDeviceFound, onDone: _onScanDone, cancelOnError: true);
  
// Stop the scan prematurely
subscription.cancel();

// Example of the callbacks
void _onDeviceFound(ScanResult result) {
  // TODO: Use ScanResult here, for instance to update the list of found devices.
}

void _onScanDone() {
  // This will be called when the scan is finished (timeout is reached)
}
```

## Connecting to a device
After the scan is complete, you can use the `device` from a `ScanResult` to setup a "serial" connection and exchange data.
```dart
var serial = SerialConnectionProvider().init(scanResult.device);

// Listen for connection state changes
var stateSubscription = serial.onStateChange.listen(_updateConnectionState);

void _updateConnectionState(SerialConnectionState state) {
  // TODO: Update UI to show current connection state
  debugPrint('SerialConnectionState: ${state.toString()}');
}

// Listen for incoming data
var dataSubscription = serial.onTextReceived.listen(_receive);

void _receive(String text) {
  // TODO: Handle incoming data
  debugPrint('IN: ${text}');
}

// Connect to device
serial.connect();

// Send data
serial.sendText('Hello BLE device!');

// ..or disconnect from the device
serial.disconnect();
```