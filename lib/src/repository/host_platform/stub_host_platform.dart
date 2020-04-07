import 'package:flutter/foundation.dart' show kIsWeb;
import 'base_host_platform.dart';

export 'base_host_platform.dart';

HostPlatform getHostPlatform() => UnknownHostPlatform();

class UnknownHostPlatform implements HostPlatform {
  final HostPlatformType type = kIsWeb ? HostPlatformType.web : HostPlatformType.io;
  final OperatingSystem operatingSystem = OperatingSystem.unknown;
  final String version = 'unknown';
  final num versionNumber = .0;
  final String locale = 'en';
}
