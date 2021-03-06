import 'dart:html' as html show window, document;
import 'base_host_platform.dart';

export 'base_host_platform.dart';


HostPlatform getHostPlatform() => WebHostPlatform();

class WebHostPlatform implements HostPlatform {
  @override
  final HostPlatformType type = HostPlatformType.web;
  @override
  final OperatingSystem operatingSystem = _getOS();
  @override
  final String version = _getVersion();
  @override
  num get versionNumber => num.tryParse(version?.split(' ')?.first ?? '0.0') ?? .0;
  @override
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
  static String _getLocale() {
    String lang = html.window.navigator.language?.split('-')?.first?.split('_')?.first?.trim()?.toLowerCase();
    if (lang is! String || lang.length != 2) return 'en';
    return lang;
  }

  @override
  void setThemeColor(String color) {
    html.document.querySelector('meta[name=theme-color]').attributes['content'] = color;
  }

  @override
  void setBackgroundColor(String color) {
    html.document.body.style
      ..background = color
      ..backgroundColor = color;
  }
}


