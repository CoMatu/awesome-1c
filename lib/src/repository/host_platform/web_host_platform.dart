import 'dart:html' as html show window;
import 'package:awesome1c/src/repository/host_platform/base_host_platform.dart';
export 'package:awesome1c/src/repository/host_platform/base_host_platform.dart';


HostPlatform getHostPlatform() => WebHostPlatform();

class WebHostPlatform implements HostPlatform {
  final HostPlatformType type = HostPlatformType.web;
  final OperatingSystem operatingSystem = _getOS();
  final String version = _getVersion();
  num get versionNumber => num.tryParse(version?.split(' ')?.first ?? '0.0') ?? .0;
  final String locale = _getLocale();
  static OperatingSystem _getOS() {
    final String appVersion = html.window?.navigator?.appVersion?.toLowerCase() ?? '';
    if (appVersion.contains('android')) {
      return OperatingSystem.android;
    } else if (appVersion.contains('iphone')) {
      return OperatingSystem.iOS;
    } else if (appVersion.contains('fuchsia')) {
      return OperatingSystem.fuchsia;
    } else if (appVersion.contains('linux')) {
      return OperatingSystem.linux;
    } else if (appVersion.contains('mac')) {
      return OperatingSystem.macOS;
    }else if (appVersion.contains('windows')) {
      return OperatingSystem.windows;
    }
    return OperatingSystem.unknown;
  }
  static String _getVersion() =>
    html.window.navigator.appVersion ?? '0.0';
  static String _getLocale() =>
    html.window.navigator.language ?? 'en';
}


