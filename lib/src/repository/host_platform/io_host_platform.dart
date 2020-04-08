import 'dart:io' as io;
import 'base_host_platform.dart';

export 'base_host_platform.dart';

HostPlatform getHostPlatform() => IOHostPlatform();

class IOHostPlatform implements HostPlatform {
  @override
  final HostPlatformType type = HostPlatformType.io;
  @override
  final OperatingSystem operatingSystem = _getOS();
  @override
  final String version = _getVersion();
  @override
  num get versionNumber => num.tryParse(version?.split(' ')?.first ?? '0.0') ?? .0;
  @override
  final String locale = _getLocale();
  static OperatingSystem _getOS() {
    if (io.Platform.isFuchsia) {
      return OperatingSystem.fuchsia;
    } else if (io.Platform.isWindows) {
      return OperatingSystem.windows;
    } else if (io.Platform.isLinux) {
      return OperatingSystem.linux;
    } else if (io.Platform.isAndroid) {
      return OperatingSystem.android;
    } else if (io.Platform.isIOS) {
      return OperatingSystem.iOS;
    } else if (io.Platform.isMacOS) {
      return OperatingSystem.macOS;
    }
    return OperatingSystem.unknown;
  }
  static String _getVersion() =>
    io.Platform.operatingSystemVersion;
  static String _getLocale() =>
    io.Platform.localeName ?? 'en';

  @override
  void setThemeColor(String _) => null;

  @override
  void setBackgroundColor(String _) => null;
}

