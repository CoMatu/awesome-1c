import 'package:awesome1c/src/repository/host_platform/base_host_platform.dart';
export 'package:awesome1c/src/repository/host_platform/base_host_platform.dart';

HostPlatform getHostPlatform() => UnknownHostPlatform();

class UnknownHostPlatform implements HostPlatform {
  final HostPlatformType type = HostPlatformType.unknown;
  final OperatingSystem operatingSystem = OperatingSystem.unknown;
  final String version = 'unknown';
  final num versionNumber = .0;
  final String locale = 'en';
}
