import 'package:flutter/foundation.dart' show kIsWeb;

enum HostPlatformType {
  web,
  io,
  unknown,
}

enum OperatingSystem {
  fuchsia,
  linux,
  macOS,
  windows,
  iOS,
  android,
  unknown,
}

abstract class HostPlatform {
  final HostPlatformType type = kIsWeb ? HostPlatformType.web : HostPlatformType.io;
  final OperatingSystem operatingSystem = OperatingSystem.unknown;
  final String version = 'unknown';
  final num versionNumber = .0;
  final String locale = 'en';

  void setThemeColor(String color);
  void setBackgroundColor(String color);
}

