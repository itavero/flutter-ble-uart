/// Package to integrate UART (Serial) over Bluetooth Low Energy into your Flutter app
library flutter_ble_uart;

import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'dart:convert';

part 'src/exceptions.dart';

part 'src/serial_service_config.dart';

part 'src/serial_connection_provider.dart';

part 'src/serial_connection.dart';
