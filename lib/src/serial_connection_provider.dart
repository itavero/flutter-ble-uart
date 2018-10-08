part of flutter_ble_uart;

/// Singleton class that abstracts away the lower level Bluetooth stuff.
class SerialConnectionProvider {
  static final SerialConnectionProvider _singleton =
      new SerialConnectionProvider._internal();
  final FlutterBlue _ble = FlutterBlue.instance;
  SerialServiceConfig _config;

  factory SerialConnectionProvider() {
    return _singleton;
  }

  /// Constructor used to generate the singleton
  SerialConnectionProvider._internal() {
    _config = NordicSerialServiceConfig();
  }

  /// Change the SerialServiceConfig (defaults to NordicSerialServiceConfig)
  void setConfig(SerialServiceConfig config) {
    _config = config;
  }

  /// Starts a scan for Bluetooth LE devices that advertise the UART Service.
  ///
  /// Internally this calls the [FlutterBlue.scan] method.
  Stream<ScanResult> scan(
      {ScanMode scanMode = ScanMode.lowLatency,
      List<Guid> withDevices = const [],
      Duration timeout}) async* {
    yield* _ble.scan(
        scanMode: scanMode,
        withServices: [_config.serviceId],
        withDevices: withDevices,
        timeout: timeout);
  }

  /// Scan for a fixed duration and return all discovered devices afterwards.
  ///
  /// Internally this calls [scan] with the given timeout. By default
  /// the timeout is set to 10 seconds.
  Future<Iterable<BluetoothDevice>> simplifiedScan({Duration timeout}) async {
    if (timeout == null) {
      timeout = Duration(seconds: 10);
    }

    Map<String, BluetoothDevice> devices = {};
    devices.addEntries(await scan(timeout: timeout)
        .map((sr) => MapEntry(sr.device.id.id, sr.device))
        .toList());
    return devices.values;
  }

  /// Initialize a serial connection with the given device.
  SerialConnection init(BluetoothDevice device) {
    return SerialConnection(this, device);
  }
}
