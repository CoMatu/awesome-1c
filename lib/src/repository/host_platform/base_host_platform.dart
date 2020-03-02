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

class HostPlatform {
  final HostPlatformType type = HostPlatformType.unknown;
  final OperatingSystem operatingSystem = OperatingSystem.unknown;
  final String version = 'unknown';
  final num versionNumber = .0;
  final String locale = 'en';
}