part of flutter_ble_uart;

/// Configuration for a serial service
class SerialServiceConfig {
  /// UUID of the GATT service.
  final Guid serviceId;

  /// UUID of the TX characteristic.
  ///
  /// The software will write the *outgoing* data to this characteristic.
  final Guid txCharacteristicId;

  /// UUID of the RX characteristic.
  ///
  /// The software will subscribe to notifications for the *incoming* data.
  final Guid rxCharacteristicId;

  /// Maximum number of bytes (chunk size) for the TX characteristic.
  ///
  /// Defaults to 20. Allows you to set how many bytes will be send at once.
  final int lengthOfCharacteristic;

  SerialServiceConfig(
      this.serviceId, this.txCharacteristicId, this.rxCharacteristicId,
      [this.lengthOfCharacteristic = 20]);
}

/// Configuration for the Nordic UART Service
class NordicSerialServiceConfig extends SerialServiceConfig {
  NordicSerialServiceConfig()
      : super(
            Guid('6E400001-B5A3-F393-­E0A9-­E50E24DCCA9E'),
            Guid('6E400002-B5A3-F393-­E0A9-­E50E24DCCA9E'),
            Guid('6E400003-B5A3-F393-­E0A9-­E50E24DCCA9E'),
            20);
}
