// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'host_platform/stub_host_platform.dart'
  // ignore: uri_does_not_exist
  if (dart.library.html) 'host_platform/web_host_platform.dart'
  // ignore: uri_does_not_exist
  if (dart.library.io) 'host_platform/io_host_platform.dart';


// Перечисление режимов запуска приложения
enum BuildMode {
  release
  , profile
  , debug
}

///
class Platform {
  ///
  final BuildMode buildMode;

  ///
  HostPlatformType get type => hostPlatform.type ?? HostPlatformType.unknown;

  ///
  OperatingSystem get operatingSystem => hostPlatform.operatingSystem ?? OperatingSystem.unknown;

  ///
  String get version => hostPlatform.version;

  ///
  num get versionNumber => hostPlatform.versionNumber;

  ///
  String get locale => hostPlatform.locale;

  ///
  bool get isPlatformKnown => type != HostPlatformType.unknown;

  ///
  bool get isOperatingSystemKnown => operatingSystem != OperatingSystem.unknown;

  ///
  bool get isMobile => [OperatingSystem.android, OperatingSystem.iOS].contains(operatingSystem);

  ///
  final HostPlatform hostPlatform;

  ///
  bool isUnitTesting = false;

  /// Получить режим запуска приложения
  static BuildMode _getCurrentBuildMode() =>
    (() {
      if (const bool.fromEnvironment('dart.vm.product')) {
        return BuildMode.release;
      }
      BuildMode result = BuildMode.profile;
      assert(() {
        result = BuildMode.debug;
        return true;
      }());
      return result;
    }());

  ///
  static HostPlatform _getHostPlatform() => getHostPlatform();

  @override
  int get hashCode => 0;
  @override
  bool operator ==(Object obj) => obj is Platform;
  @override
  String toString() =>
    'Type: $type'
    r', '
    'OS: $operatingSystem'
    r', '
    'Version: $version'
    r'.';

  // SINGLETON +
  static final Platform _this = Platform._internal();
  factory Platform() => _this;
  Platform._internal()
    : hostPlatform = _getHostPlatform()
    , buildMode = _getCurrentBuildMode();
  // SINGLETON -
}