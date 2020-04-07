import 'package:flutter/foundation.dart' show kIsWeb;
import 'base_host_platform.dart';

export 'base_host_platform.dart';

HostPlatform getHostPlatform() => UnknownHostPlatform();

class UnknownHostPlatform implements HostPlatform {
  @override
  final HostPlatformType type = kIsWeb ? HostPlatformType.web : HostPlatformType.io;
  @override
  final OperatingSystem operatingSystem = OperatingSystem.unknown;
  @override
  final String version = 'unknown';
  @override
  final num versionNumber = .0;
  @override
  final String locale = 'en';
}
