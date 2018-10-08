part of flutter_ble_uart;

/// Base class for all exceptions that can be thrown from [SerialConnection].
class SerialConnectionException implements Exception {
  final String cause;

  SerialConnectionException(this.cause);

  @override
  String toString() {
    return 'SerialConnectionException($cause)';
  }
}

/// Thrown when a requested operation cannot be performed in the current state.
class SerialConnectionWrongStateException extends SerialConnectionException {
  SerialConnectionWrongStateException(SerialConnectionState currentState)
      : super('Operation cannot be performed, '
            'because state is ${currentState.toString()}.');
}

/// Thrown when trying to connect with a device that does advertise the
/// configured UART service.
class SerialConnectionServiceNotFoundException
    extends SerialConnectionException {
  SerialConnectionServiceNotFoundException(SerialServiceConfig config)
      : super('Service with identifier ${config.serviceId.toString()}'
            ' was not found.');
}

/// Thrown when any of the configured characteristics can not be found in the
/// configured service.
class SerialConnectionCharacteristicNotFoundException
    extends SerialConnectionException {
  SerialConnectionCharacteristicNotFoundException(Guid characteristicId)
      : super('Characteristic with identifier ${characteristicId.toString()}'
            ' was not found.');
}

class SerialConnectionNotReadyException extends SerialConnectionException {
  SerialConnectionNotReadyException()
      : super('Serial connection is not yet ready to perform the requested'
            ' operation.');
}
