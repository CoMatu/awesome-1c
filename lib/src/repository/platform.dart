import 'package:awesome1c/src/repository/host_platform/stub_host_platform.dart'
  // ignore: uri_does_not_exist
  if (dart.library.html) 'package:awesome1c/src/repository/host_platform/web_host_platform.dart'
  // ignore: uri_does_not_exist
  if (dart.library.io) 'package:awesome1c/src/repository/host_platform/io_host_platform.dart';

// Перечисление режимов запуска приложения
enum BuildMode {
  release
  , profile
  , debug
}

class Platform {
  final HostPlatform _hostPlatform;
  final BuildMode buildMode;
  HostPlatformType get type => this._hostPlatform.type ?? HostPlatformType.unknown;
  OperatingSystem get operatingSystem => this._hostPlatform.operatingSystem ?? OperatingSystem.unknown;
  String get version => this._hostPlatform.version;
  num get versionNumber => this._hostPlatform.versionNumber;
  String get locale => this._hostPlatform.locale;
  bool get isPlatformKnown => this.type != HostPlatformType.unknown;
  bool get isOperatingSystemKnown => this.operatingSystem != OperatingSystem.unknown;
  bool get isMobile => [OperatingSystem.android, OperatingSystem.iOS].contains(this.operatingSystem);

  bool isUnitTesting = false;

  // Получить режим запуска приложения
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

  static HostPlatform _getHostPlatform() => getHostPlatform();

  // SINGLETON +
  static final Platform _this = Platform._internal();
  factory Platform() => _this;
  Platform._internal()
    : this._hostPlatform = _getHostPlatform()
    , this.buildMode = _getCurrentBuildMode();
  // SINGLETON -
}